return {

	-- ===========================================================================
	-- Mason LSP-config
	-- ===========================================================================
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	-- ===========================================================================
	-- This is for Linters through Mason
	-- ===========================================================================

	{
		"rshkarin/mason-nvim-lint",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"shellcheck",
				"flake8",
				"eslint_d",
			},
			ignore_install = { "rust_clippy" },
		},
	},

	{
		-- ===========================================================================
		-- This is for Rust LSPConfig
		-- ===========================================================================
		"neovim/nvim-lspconfig",
		config = function()
			-- Configure rust-analyzer
			vim.lsp.config("rust_analyzer", {
				cmd = {
					vim.fn.expand(
						"~/.rustup/toolchains/" .. vim.fn.trim(vim.fn.system("rustup default")) .. "/bin/rust-analyzer"
					),
				},
			})

			-- Enable rust-analyzer
			vim.lsp.enable("rust_analyzer")
		end,
	},

	-- ===========================================================================
	-- This is for Lint
	-- ===========================================================================
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters.rust_clippy = {
				cmd = "cargo",
				args = { "clippy", "--message-format=json" },
				stdin = false,
			}

			lint.linters_by_ft = {
				python = { "flake8" },
				sh = { "shellcheck" },
				rust = { "rust_clippy" },
			}

			-- run linter on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})

			-- diagnostics float on CursorHold (nvim-lint + LSP)
			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})
		end,
	},
}
