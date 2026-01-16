return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				["clang-format"] = {
					args = {
						"--assume-filename",
						"$FILENAME",
						"--style={BasedOnStyle: LLVM, BreakBeforeBraces: Allman, IndentWidth: 2, UseTab: Never, ColumnLimit: 100}",
					},
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang-format" },
				c = { "clang-format" }
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000,
			-- },
		})

		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = " Prettier Format whole file or range (in visual mode) with" })
	end,
}
