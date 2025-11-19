return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "black" }, -- use Black for Python
			rust = { "rustfmt" },
		},

		-- Autoformat on save
		format_on_save = {
			enabled = true,
			timeout_ms = 1500,
			lsp_fallback = true, -- fallback to LSP formatting if no external formatter found
		},

		-- If you want to explicitly control the binary path you can supply one like:
		-- formatter_opts = {
		--   black = { command = vim.fn.stdpath("data") .. "/mason/bin/black" },
		-- },
	},
	config = function(_, opts)
		require("conform").setup(opts or {})
	end,
}
