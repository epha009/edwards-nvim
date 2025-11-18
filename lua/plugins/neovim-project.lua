return {
	{
		"coffebar/neovim-project",
		opts = {
			-- Project directories
			projects = {
				"~/Code/*",
			},
			-- Path to store history and sessions
			datapath = vim.fn.stdpath("data"), -- ~/.local/share/nvim/
			-- Load the most recent session on startup if not in the project directory
			last_session_on_startup = true,
			-- Dashboard mode prevents session autoload on startup
			dashboard_mode = false,
			-- Timeout in milliseconds before triggering FileType autocmd after session load
			filetype_autocmd_timeout = 200,
			-- Keymap to delete project from history in Telescope picker
			forget_project_keys = {
				i = "<C-d>", -- insert mode
				n = "d", -- normal mode
			},
			-- Follow symbolic links in glob patterns (affects startup speed)
			follow_symlinks = "full", -- "full", "partial", "none"

			-- Overwrite some of Session Manager options
			session_manager_opts = {
				autosave_ignore_dirs = {
					vim.fn.expand("~"), -- don't create a session for $HOME/
					"/tmp",
				},
				autosave_ignore_filetypes = {
					"ccc-ui",
					"dap-repl",
					"dap-view",
					"dap-view-term",
					"gitcommit",
					"gitrebase",
					"qf",
					"toggleterm",
				},
			},

			-- Picker to use for project selection
			picker = {
				type = "telescope", -- "telescope", "fzf-lua", or "snacks"
				preview = {
					enabled = true, -- show directory structure in Telescope preview
					git_status = true, -- show branch and git status of files/folders
					git_fetch = false, -- fetch from remote for ahead/behind info
					show_hidden = true, -- show hidden files/folders
				},
				opts = {
					-- picker-specific options
				},
			},
		},
		init = function()
			-- enable saving the state of plugins in the session
			vim.opt.sessionoptions:append("globals") -- save global variables that start with uppercase letter and at least one lowercase
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
			{ "ibhagwan/fzf-lua" },
			{ "folke/snacks.nvim" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
	},
}
