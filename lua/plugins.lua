-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("yamatsum/nvim-cursorline")
	require("nvim-cursorline").setup({
		cursorline = {
			enable = true,
			timeout = 1000,
			number = false,
		},
		cursorword = {
			enable = true,
			min_length = 3,
			hl = { underline = true },
		},
	})
	use("ghifarit53/tokyonight-vim")
	use("folke/tokyonight.nvim")
	use("Mofiqul/dracula.nvim")
	use("ayu-theme/ayu-vim")
	use("rebelot/kanagawa.nvim")
	use({ "daltonmenezes/aura-theme", rtp = "packages/neovim" })
	use("bluz71/vim-moonfly-colors")
	use("dasupradyumna/midnight.nvim")
	use("oxfist/night-owl.nvim")
	use("tomasr/molokai")
	use("NLKNguyen/papercolor-theme")
	use("nanotech/jellybeans.vim")
	use("tiagovla/tokyodark.nvim")
	--    use 'tanvirtin/monokai.nvim'

	use({
		"williamboman/mason.nvim",
		run = ":MasonUpdate", -- :MasonUpdate updates registry contents
	})
	use({ "williamboman/mason-lspconfig.nvim" })
	-- Packer
	use({
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				-- add any options here
			})
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})
	use({ "neovim/nvim-lspconfig" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "L3MON4D3/LuaSnip" })
	--[[ use({
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
})
    use 'saadparwaiz1/cmp_luasnip'
	]]
	--
	-- use {'edluffy/hologram.nvim'}
	-- You can alias plugin names
	use({ "dracula/vim", as = "dracula" })
	-- Superuser's recs
	use({
		"s1n7ax/nvim-terminal",
		config = function()
			vim.o.hidden = true
			require("nvim-terminal").setup()
		end,
	})
	use("mechatroner/rainbow_csv")
	use("godlygeek/tabular")
	use("mrcjkb/rustaceanvim")
	use("Saecki/crates.nvim")
	use("nvim-lua/plenary.nvim")
	--use("anthonymolinari/latex_preview.nvim")
	--use("emakman/nvim-latex-previewer")
	use("lervag/vimtex")
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	--
	--use("edluffy/hologram.nvim")
	--use("Vaisakhkm2625/hologram-math-preview.nvim")
	use("3rd/image.nvim")
	--use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-dap")
	use("nvim-treesitter/nvim-treesitter")
	use("Myzel394/easytables.nvim")
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-tree/nvim-web-devicons")
	use("projekt0n/github-nvim-theme")

	use("lukas-reineke/indent-blankline.nvim")
	use("https://gitlab.com/HiPhish/rainbow-delimiters.nvim")

	--[[	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
	})
	]]
	--
	use({
		"epwalsh/pomo.nvim",
		tag = "*", -- Recommended, use latest release instead of latest commit
		requires = {
			-- Optional, but highly recommended if you want to use the "Default" timer
			"rcarriga/nvim-notify",
		},
	})
	--    use 'nvim-tree/nvim-tree.lua'
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	-- Lua
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use("vlime/vlime")
	-- use("ray-x/go.nvim")
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	-- autodetecting files without suffixes as binary??
	use({ "RaafatTurki/hex.nvim" })
	use({ "romgrk/barbar.nvim", requires = "nvim-tree/nvim-web-devicons" })
	use("voldikss/vim-floaterm")
	-- use 'nvim-telescope/telescope.nvim'
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" }, { "BurntSushi/ripgrep" } },
	})
	use("andweeb/presence.nvim")
	--  use 'vimwiki/vimwiki'
	use("echasnovski/mini.indentscope")
	use("amitds1997/remote-nvim.nvim")
	use("MunifTanjim/nui.nvim")
	use("rcarriga/nvim-notify")
	--    use 'folke/noice.nvim'
	use("nvim-lualine/lualine.nvim")
	use("chaimleib/vim-renpy")

	-- LSP completion source:
	use("hrsh7th/cmp-nvim-lsp")

	-- Useful completion sources:
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	--nvim-cmp
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })
	-- redundant with multicursor
	use({ "mg979/vim-visual-multi" })
	use("jake-stewart/multicursor.nvim")
	use("nvchad/menu")
	use("nvchad/volt")
	use("nvchad/minty")
	use("OXY2DEV/markview.nvim")
	use({ "lewis6991/gitsigns.nvim" })
	use({ "beauwilliams/focus.nvim" })
	use({ "mhartington/formatter.nvim" })
	use("Eandrju/cellular-automaton.nvim")
	use("jakewvincent/mkdnflow.nvim")
	use("b0o/schemastore.nvim")
	use("stevearc/overseer.nvim")
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	-- Lua
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	--use("intangiblematter/csvview.nvim")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
