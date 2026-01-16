return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
		-- "saghen/blink.cmp",
	},
	config = function()
		-- import mason and mason_lspconfig
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Provides mason-names e.g: 'lua_ls' instead of 'lua-language-server'
		mason_lspconfig.setup({
			automatic_enable = false,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"lua_ls",
				"stylua", -- lua formatter
				"clangd",
				"clang-format",
				"codelldb",
				"bashls",
				"basedpyright",
				"ruff",
				"debugpy",
				"lemminx"
			},
		})
	end,
}
