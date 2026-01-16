vim.keymap.set("n", "<leader>x", function()
	vim.cmd("update")
	vim.cmd("belowright split | resize 12")
	local file = vim.fn.shellescape(vim.fn.expand("%"))
	vim.cmd(
		"terminal g++ -std=c++20 -g -O0 -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -o run_cpp "
			.. file
			.. " && time ./run_cpp"
	)
	vim.cmd("startinsert")
end, { buffer = true, desc = "Compile and run current cpp file" })

local uv = vim.uv or vim.loop

local function exists(p) return uv.fs_stat(p) ~= nil end

local function read_all(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local s = f:read("*a")
  f:close()
  return s
end

local function find_pkg_root(start_dir)
  local dir = start_dir
  while dir and dir ~= "/" do
    if exists(dir .. "/package.xml") and exists(dir .. "/CMakeLists.txt") then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then break end
    dir = parent
  end
end

local function infer_target_from_cmake(pkg_root, rel_cpp, basename)
  local cm = read_all(pkg_root .. "/CMakeLists.txt")
  if not cm then return nil end
  cm = cm:gsub("#[^\n]*", "") -- strip comments

  local funcs = { "add_executable", "ament_add_executable" }
  for _, fn in ipairs(funcs) do
    for block in cm:gmatch(fn .. "%s*(%b())") do
      local args = block:sub(2, -2)
      local toks = {}
      for tok in args:gmatch("%S+") do
        tok = tok:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
        table.insert(toks, tok)
      end

      local target = toks[1]
      if target then
        for i = 2, #toks do
          local t = toks[i]
          if t == rel_cpp
            or t:sub(-#rel_cpp) == rel_cpp
            or t == basename
            or t:sub(-#basename) == basename then
            return target
          end
        end
      end
    end
  end
  return nil
end

vim.keymap.set("n", "<leader>X", function()
  vim.cmd("update")

  local file = vim.fn.expand("%:p")
  local file_dir = vim.fn.fnamemodify(file, ":h")

  local pkg_root = find_pkg_root(file_dir)
  if not pkg_root then
    vim.notify("ROS2: couldn't find package.xml + CMakeLists.txt above:\n" .. file, vim.log.levels.ERROR)
    return
  end

  local rel_cpp = file:sub(#pkg_root + 2)
  local basename = vim.fn.fnamemodify(file, ":t")

  local target = infer_target_from_cmake(pkg_root, rel_cpp, basename)
  if not target then
    vim.notify(
      ("ROS2: couldn't infer target for %s.\nMake sure this .cpp is listed in add_executable(...) in %s/CMakeLists.txt")
        :format(rel_cpp, pkg_root),
      vim.log.levels.ERROR
    )
    return
  end

  local build_dir = pkg_root .. "/.nvim-build"
  local run_link  = build_dir .. "/run_cpp"

  -- We'll run in a split terminal. Use bash -lc so `source` works.
  local script = table.concat({
    "set -e",
    "source /opt/ros/jazzy/setup.bash",
    -- if you have workspace-built deps, this helps CMake find them:
    "[ -f " .. vim.fn.shellescape(pkg_root .. "/../..") .. "/install/setup.bash ] && source "
      .. vim.fn.shellescape(pkg_root .. "/../..") .. "/install/setup.bash || true",

    "cmake -S " .. vim.fn.shellescape(pkg_root)
      .. " -B " .. vim.fn.shellescape(build_dir)
      .. " -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON",

    "cmake --build " .. vim.fn.shellescape(build_dir) .. " -j\"$(nproc)\" --target " .. vim.fn.shellescape(target),

    -- make a stable name for running/debugging
    "ln -sf " .. vim.fn.shellescape(build_dir .. "/" .. target) .. " " .. vim.fn.shellescape(run_link),

    "echo",
    "echo '[nvim] built target: " .. target .. "'",
    "echo '[nvim] run: " .. run_link .. "'",
    "echo",
    vim.fn.shellescape(run_link) .. " || true",
  }, "; ")

  vim.cmd("belowright split | resize 12")
  vim.cmd("terminal bash -lc " .. vim.fn.shellescape(script))
  vim.cmd("startinsert")
end, { buffer = true, desc = "CMake (pkg): build target for current .cpp and run as run_cpp" })
