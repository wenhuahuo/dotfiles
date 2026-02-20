-- lua/plugins/illuminate.lua
return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",   -- 常见的懒加载事件
    config = function()
      require("illuminate").configure({
        -- 这里是默认配置，可以按需覆盖
        delay = 100,
        large_file_cutoff = 2000,
      })
	        -- 绑定快捷键
      vim.keymap.set(
        "n",
        "<Leader>nn",
        function()
          require("illuminate").goto_next_reference(true)
        end,
        { desc = "Illuminate: Next reference" }
      )

      vim.keymap.set(
        "n",
        "<Leader>N",
        function()
          require("illuminate").goto_prev_reference(true)
        end,
        { desc = "Illuminate: Prev reference" }
      )
    end,
  },
}

