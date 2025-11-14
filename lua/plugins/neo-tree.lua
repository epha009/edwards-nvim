-- init.lua or lua/plugins/neo-tree.lua if using Lazy.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- closes Neo-tree if it's the last window
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        container = { enable_character_fade = true },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "ﰊ",
          default = "",
        },
        name = { trailing_slash = false, use_git_status_colors = true },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "",
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          }
        },
      },
      window = {
        position = "left",
        width = 35,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["R"] = "refresh",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
        }
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      buffers = { show_unloaded = true },
      git_status = { window = { position = "float" } },
    })

    -- Optional: keymap to toggle Neo-tree
    vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
  end
}
