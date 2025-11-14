return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,        -- load immediately
    priority = 1000,     -- load first so it sets colors
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = true,
          notify = true,
          mini = true,
        },
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

