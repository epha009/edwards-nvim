
-- lua/plugins/luasnip.lua
return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local ok, luasnip = pcall(require, "luasnip")
    if not ok then return end

    -- Load friendly-snippets if installed (optional)
    pcall(function() require("luasnip.loaders.from_vscode").lazy_load() end)

    -- Example: simple keymaps for jumping in snippet
    vim.keymap.set({"i","s"}, "<C-j>", function()
      if luasnip.jumpable(1) then luasnip.jump(1) end
    end, { silent = true })

    vim.keymap.set({"i","s"}, "<C-k>", function()
      if luasnip.jumpable(-1) then luasnip.jump(-1) end
    end, { silent = true })
  end
}
