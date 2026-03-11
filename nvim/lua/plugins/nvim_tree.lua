return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
	  filters = {
		  git_ignored = false,
	  },
	  git = {
		  enable = true,
	  },
	}
  end,
  keys = {
	  { "<leader>nt", "<Cmd>NvimTreeToggle<CR>", desc = "nvim tree toggle", silent = true },
  }
}
