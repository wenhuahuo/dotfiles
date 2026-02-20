return {
    "nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
    -- event = "VeryLazy",
    opts = {
        ensure_installed = { "lua", "python" },
        highlight = { enable = true },
		indent = { enable = true }
    },
}

