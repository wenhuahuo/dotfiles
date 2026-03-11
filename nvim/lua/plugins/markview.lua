-- For `plugins/markview.lua` users.
return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    -- dependencies = { "saghen/blink.cmp" },
	config = function()
		require("markview").setup({
			latex = {
				enable = true,     -- 启用 LaTeX 支持
				-- 内联渲染
				inline = { enable = true },
				-- 块级公式渲染
				block  = { enable = true },
				-- 括号/符号等可选
				brackets = { enable = true, hl = "@punctuation.brackets" },
		  	},
		  	-- （可选）Markdown 预览配置
		  	markdown = { enable = true },
		})
	  end,
};
