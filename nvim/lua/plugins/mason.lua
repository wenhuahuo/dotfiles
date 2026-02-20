return{
	"mason-org/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason-lspconfig.nvim",
	},
	opts = {},
	config = function (_, opts)
		require("mason").setup(opts)
		local registry = require "mason-registry"

		local success, package = pcall(registry.get_package, "lua-language-server")
		if success and not package:is_installed() then
			package:install()
		end

		local nvim_lsp = require("mason-lspconfig").get_mappings().package_to_lspconfig["lua-language-server"]
		vim.lsp.config(nvim_lsp, {})

		vim.lsp.enable('pyright')

		vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
            signs = true,
            status = true,

        })
	end,
}
