return {
  {
    "numToStr/Comment.nvim",
    opts = {
      options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      -- Disable default mappings to avoid conflicts
      mappings = {
        comment = "",
        comment_line = "",
        comment_visual = "",
        textobject = "gc",
      },
      hooks = {
        pre = function() end,
        post = function() end,
      },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
      
      -- Ctrl+/ is actually seen as Ctrl+_ in terminals
      vim.keymap.set("n", "<C-_>", function()
        return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
      end, { expr = true, desc = "Toggle comment line" })
      
      vim.keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment selection" })
    end,
  },
}
