return {
	"akinsho/bufferline.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{ "<leader>bh", ":BufferLineCyclePrev<CR>", silent = true },
		{ "<leader>bl", ":BufferLineCycleNext<CR>", silent = true },
		{ "<leader>bo", ":BufferLineCloseOthers<CR>", silent = true },
		{ "<leader>bp", ":BufferLinePick<CR>", silent = true },
		{ "<leader>bc", ":BufferLinePickClose<CR>", silent = true },
		{ "<leader>bd", ":bdelete<CR>", silent = true },
	},
}
