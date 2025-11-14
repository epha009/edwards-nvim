-- ~/.config/nvim/lua/configs/keymaps.lua
-- VS Code-style keymaps for Neovim

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shortcut helper
local map = vim.keymap.set

-- ============================
-- File operations
-- ============================
map('n', '<C-s>', ':w<CR>', { silent = true })           -- Ctrl+S → Save
map('i', '<C-s>', '<Esc>:w<CR>a', { silent = true })     -- Save in insert mode
map('n', '<C-q>', ':q<CR>', { silent = true })           -- Ctrl+Q → Quit

-- ============================
-- Copy, Paste, Cut (system clipboard)
-- ============================
map('v', '<C-c>', '"+y', { silent = true })              -- Ctrl+C → Copy selection
map('v', '<C-x>', '"+d', { silent = true })              -- Ctrl+X → Cut selection
map('n', '<C-v>', '"+p', { silent = true })              -- Ctrl+V → Paste after cursor
map('v', '<C-v>', '"+p', { silent = true })              -- Ctrl+V → Paste over selection
map('i', '<C-v>', '<Esc>"+pa', { silent = true })        -- Ctrl+V in insert mode

-- ============================
-- Select All
-- ============================
map('n', '<C-a>', 'ggVG', { silent = true })             -- Ctrl+A → Select all

-- ============================
-- Undo / Redo
-- ============================
map('n', '<C-z>', 'u', { silent = true })                -- Ctrl+Z → Undo normal mode
map('i', '<C-z>', '<Esc>u', { silent = true })           -- Ctrl+Z → Undo insert mode
map('n', '<C-S-z>', '<C-r>', { silent = true })          -- Ctrl+Shift+Z → Redo normal mode
map('i', '<C-S-z>', '<Esc><C-r>a', { silent = true })    -- Ctrl+Shift+Z → Redo insert mode

-- ============================
-- Find / Replace
-- ============================
map('n', '<C-f>', '/', { silent = true })                -- Ctrl+F → Start search
map('v', '<C-f>', '/', { silent = true })                -- Ctrl+F → Search selection

-- ============================
-- Swap j and k 
-- ============================
map({'n', 'v', 'o'}, 'j', 'k', { noremap = true, silent = true })
map({'n', 'v', 'o'}, 'k', 'j', { noremap = true, silent = true })


-- ============================
-- Telescope Find
-- ============================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- ============================
-- Exit = esc + esc
-- ============================
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Esc><Esc>", "<Esc>:q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Esc><Esc>", "<Esc>:q<CR>", { noremap = true, silent = true })

-- ============================
-- Moving from different tabs
-- ============================
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })

vim.keymap.set("n", "<C-j>", "<C-w>k", { desc = "Move up (swapped)" })
vim.keymap.set("n", "<C-k>", "<C-w>j", { desc = "Move down (swapped)" })

-- ============================
-- Open terminal at the bottom
-- ============================

-- Toggle bottom terminal (25% height) — fixed to appear at the bottom
local term_win = nil
local term_buf = nil

vim.keymap.set("n", "<leader><CR>", function()
  -- If terminal window exists and is valid, close it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  -- Calculate 25% height
  local total = vim.o.lines
  local height = math.max(3, math.floor(total * 0.34)) -- at least 3 lines

  -- Create a split **below** the current window (so terminal is at bottom)
  vim.cmd("belowright " .. height .. "split")

  -- Remember this window
  term_win = vim.api.nvim_get_current_win()

  -- If we have a valid terminal buffer, reuse it; otherwise create a new terminal
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(term_win, term_buf)
  else
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
  end

  -- Focus the terminal window and enter insert mode so it's ready to use
  vim.api.nvim_set_current_win(term_win)
  vim.cmd("startinsert")
end, { desc = "Toggle bottom terminal (25% height)" })





-- Make ESC leave terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

