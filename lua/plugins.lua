-- we're gonna use Lazy now

return {
	-- colour schemes
	{ "tiagovla/tokyodark.nvim", lazy = false, priority = 1024 },
	{ "ghifarit53/tokyonight-vim" },
	{ "folke/tokyonight.nvim" },
	{ "Mofiqul/dracula.nvim" },
	{ "ayu-theme/ayu-vim" },
	{ "rebelot/kanagawa.nvim" },
	{
		"daltonmenezes/aura-theme",
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		end,
	},
	{ "bluz71/vim-moonfly-colors" },
	{ "dasupradyumna/midnight.nvim" },
	{ "oxfist/night-owl.nvim" },
	{ "tomasr/molokai" },
	{ "NLKNguyen/papercolor-theme" },
	{ "nanotech/jellybeans.vim" },

	-- package management
	-- mason
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- bunch of stuff to make it look good (ex: the toaster notifications)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- lsp
	{ "neovim/nvim-lspconfig", lazy = false },
	-- Debug Adapter Protocol support
	{ "mfussenegger/nvim-dap" },
	-- autocompletion
	{ "hrsh7th/cmp-nvim-lsp" },
	-- snippets
	{ "L3MON4D3/LuaSnip" },
	-- Useful completion sources:
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },

	-- syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	-- show the context of the current scope
	{ "nvim-treesitter/nvim-treesitter-context", setup = true },
	-- do the lines to show the current scope
	{ "echasnovski/mini.indentscope", version = "*", config = true },
	-- show the current indent
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		opts = {},
		config = function()
			local hooks = require("ibl.hooks")

			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)
			require("ibl").setup({ scope = { highlight = highlight } })
		end,
	},
	-- rainbow brackets
	{ url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },

	-- nicer comments
	{
		"folke/todo-comments.nvim",
		opts = {

			keywords = {
				REGION = {
					icon = "↧ ",
					color = "info",
					alt = { "region" },
				},
				ENDREGION = {
					icon = "↥ ",
					color = "info",
					alt = { "endregion" },
				},
			},
			--	pattern = [[\b?(KEYWORDS)\b?]],
			pattern = [[\b(KEYWORDS)\b]],
		},
	},
	-- formatter
	{ "mhartington/formatter.nvim" },
	-- git signs
	{ "lewis6991/gitsigns.nvim", opts = {} },

	-- highlight word that cursor is on
	{ "yamatsum/nvim-cursorline" },
	-- Multi cursors
	{ "mg979/vim-visual-multi" },

	-- terminal
	-- removed: "s1n7ax/nvim-terminal" - don't think I ever used it lol
	{ "voldikss/vim-floaterm", lazy = false },

	-- shortcuts
	-- automatic pairs of things
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	-- quickly comment things
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- reminders of keys
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- search files
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- window layout/style stuff
	-- window views
	{
		"nvim-focus/focus.nvim",
		version = "*",
		opts = {
			enable = true,
			commands = true,
			autoresize = {
				enable = true,
				width = 0,
				height = 0,
				minwidth = 0,
				minheight = 0,
				height_quickfix = 10,
			},
			split = {
				bufnew = false,
				tmux = false,
			},
			ui = {
				number = false,
				relativenumber = false,
				hybridnumber = false,
				absolutenumber_unfocussed = false,

				cursorline = true,
				cursorcolumn = false,
				colorcolumn = {
					enable = false,
					list = "+1",
				},
				signcolumg = true,
				winhighlight = false,
			},
		},
	},
	-- tab bar at the top
	{
		"romgrk/barbar.nvim",
		lazy = false,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {},
	},
	-- file tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "<leader>]", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				update_cwd = true,
				on_attach = my_on_attach,
			})
		end,
	},
	-- startup greeter when I don't open a specific folder
	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	-- right click menu
	{ "nvzone/volt", lazy = true },
	{ "nvzone/menu", lazy = true },

	-- filetype/language specific
	-- CSV
	-- highlighting
	{ "mechatroner/rainbow_csv" },

	-- Markdown

	-- quick table creation
	{ "Myzel394/easytables.nvim", ft = "markdown" },
	-- latex support
	{ "lervag/vimtex" },
	-- preview in editor
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},
	-- preview the markdown on a site
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- JSON
	-- json schema support
	{ "b0o/schemastore.nvim" },
	-- Renpy
	{ "chaimleib/vim-renpy", ft = "renpy" },
	-- Rust
	{ "mrcjkb/rustaceanvim", ft = "rust", lazy = false },
	-- manage crates
	{
		"saecki/crates.nvim",
		tag = "stable",
		ft = "rust",
		config = function()
			require("crates").setup()
		end,
	},

	-- hex editor
	{ "RaafatTurki/hex.nvim" },

	-- utils
	-- a lot of stuff seems to use this
	{ "nvim-lua/plenary.nvim" },
}
