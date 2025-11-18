
-- lua/plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    -- optional: "onsails/lspkind-nvim" for icons
  },
  config = function()
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then return end
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then luasnip = nil end

    cmp.setup({
      snippet = {
        expand = function(args)
          if luasnip then luasnip.lsp_expand(args.body) end
        end,
      },

	mapping = {

	  -- Scroll docs
	  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
	  ["<C-f>"] = cmp.mapping.scroll_docs(4),

	  -- Use Ctrl+Down / Ctrl+Up to move in completion menu
	  ["<C-Down>"] = function(fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
	    else
	      fallback()
	    end
	  end,

	  ["<C-Up>"] = function(fallback)
	    if cmp.visible() then
	      cmp.select_prev_item()
	    else
	      fallback()
	    end
	  end,

  -- Confirm
  ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Tab/Shift-Tab behaviour for completion + snippets
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip and luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- Optional: enable cmp in commandline (:/ and ?/)
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } }
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
    })
  end
}
