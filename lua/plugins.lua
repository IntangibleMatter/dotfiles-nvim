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
	{ "tomasr/molokai" },
	{ "navarasu/onedark.nvim" },
	{ "catppuccin/nvim" },
	{ "morhetz/gruvbox" },
	{ "sainnhe/everforest" },
	{ "nordtheme/vim" },
	{ "dracula/vim" },
	{ "mhartington/oceanic-next" },
	{ "junegunn/seoul256.vim" },
	{ "samharju/synthweave.nvim" },

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

	{ "neovim/nvim-lspconfig" },
	-- lsp
	--[[{ "neovim/nvim-lspconfig", lazy = false, ensure_installed = {
		"java",
	} },]]
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

	-- view issues more easily
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	--[[{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},]]

	-- View symbols in code
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
			providers = {
				priority = { "lsp", "coc", "markdown", "norg", "treesitter" },
			},
			icons = {
				File = { icon = "󰈔", hl = "Identifier" },
				Module = { icon = "󰆧", hl = "Include" },
				Namespace = { icon = "󰅪", hl = "Include" },
				Package = { icon = "󰏗", hl = "Include" },
				Class = { icon = "𝓒", hl = "Type" },
				Method = { icon = "ƒ", hl = "Function" },
				Property = { icon = "", hl = "Identifier" },
				Field = { icon = "󰆨", hl = "Identifier" },
				Constructor = { icon = "", hl = "Special" },
				Enum = { icon = "ℰ", hl = "Type" },
				Interface = { icon = "󰜰", hl = "Type" },
				Function = { icon = "", hl = "Function" },
				Variable = { icon = "", hl = "Constant" },
				Constant = { icon = "", hl = "Constant" },
				String = { icon = "𝓐", hl = "String" },
				Number = { icon = "#", hl = "Number" },
				Boolean = { icon = "⊨", hl = "Boolean" },
				Array = { icon = "󰅪", hl = "Constant" },
				Object = { icon = "⦿", hl = "Type" },
				Key = { icon = "🔐", hl = "Type" },
				Null = { icon = "NULL", hl = "Type" },
				EnumMember = { icon = "", hl = "Identifier" },
				Struct = { icon = "𝓢", hl = "Structure" },
				Event = { icon = "🗲", hl = "Type" },
				Operator = { icon = "+", hl = "Identifier" },
				TypeParameter = { icon = "𝙏", hl = "Identifier" },
				Component = { icon = "󰅴", hl = "Function" },
				Fragment = { icon = "󰅴", hl = "Constant" },
				TypeAlias = { icon = " ", hl = "Type" },
				Parameter = { icon = " ", hl = "Identifier" },
				StaticMethod = { icon = " ", hl = "Function" },
				Macro = { icon = " ", hl = "Function" },
			},
		},
		dependencies = {
			"epheien/outline-treesitter-provider.nvim",
		},
	},

	-- this plugin for markdown needs to be laoded before treesitter otherwise
	-- it won't work right??
	--[[{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},]]

	-- syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			-- make sure markview is loaded first to avoid bugs
			{
				"OXY2DEV/markview.nvim",
				lazy = false,
				priority = 49,
			},
		},
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
	-- wrap with brackets in visual mode
	{ "bwintertkb/visual_wrap.nvim", opts = {} },

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
				view = {
					side = "left",
				},
				update_cwd = true,
				on_attach = my_on_attach,
				filters = {
					custom = {
						".\\{-}\\.uid$",
					},
				},
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
	{ "mechatroner/rainbow_csv", ft = { "csv" } },

	-- Markdown

	-- typst
	{
		"chomosuke/typst-preview.nvim",
		-- lazy = false, -- or ft = 'typst'
		ft = "typst",
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},

	-- quick table creation
	{ "Myzel394/easytables.nvim", ft = "markdown" },
	-- latex support
	{ "lervag/vimtex" },
	-- preview in editor
	-- (markdown moved elsewhere)
	-- preview the markdown on a site
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- HTML and the like
	{
		{
			"barrett-ruth/live-server.nvim",
			build = "pnpm add -g live-server",
			cmd = { "LiveServerStart", "LiveServerStop" },
			config = true,
		},
	},
	--[[{
		"brianhuster/live-preview.nvim",
		dependencies = {
			-- You can choose one of the following pickers
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
			"echasnovski/mini.pick",
		},
	},]]

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

	-- Java

	{
		"https://codeberg.org/mfussenegger/nvim-jdtls.git",
	},

	-- renpy
	{
		"inzoiniac/renpy-syntax.nvim",
		config = function()
			require("renpy-syntax").setup()
		end,
	},

	--[[{
		"nvim-java/nvim-java",
		opts = false,
		dependencies = {
			{ "williamboman/mason.nvim" },
		},
	},
	--[[{
		"nvim-java/nvim-java",
		opts = {},
	},]]

	-- hex editor
	{
		"RaafatTurki/hex.nvim",
		opts = {

			-- cli command used to dump hex data
			dump_cmd = "xxd -g 1 -u",

			-- cli command used to assemble from hex data
			assemble_cmd = "xxd -r",

			-- function that runs on BufReadPre to determine if it's binary or not
			is_file_binary_pre_read = function()
				-- logic that determines if a buffer contains binary data or not
				-- must return a bool
			end,

			-- function that runs on BufReadPost to determine if it's binary or not
			is_file_binary_post_read = function()
				-- logic that determines if a buffer contains binary data or not
				-- must return a bool
			end,
		},
	},

	-- utils
	-- a lot of stuff seems to use this
	{ "nvim-lua/plenary.nvim" },

	-- fun
	-- Track time in nvim
	-- { "wakatime/vim-wakatime", lazy = false },
	-- typing practice
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	-- colour palette helper
	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
	},
}
