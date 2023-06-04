-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
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
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'yamatsum/nvim-cursorline'
    require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
    use 'folke/tokyonight.nvim' 
    use 'Mofiqul/dracula.nvim'
    use 'ayu-theme/ayu-vim'
--    use 'tanvirtin/monokai.nvim'

use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
}
    use { 'williamboman/mason-lspconfig.nvim'}
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
        }
    })
--	use { 'hrsh7th/vim-vsnip' }
--	use { 'hrsh7th/vim-vsnip-integ' }
    use { 'neovim/nvim-lspconfig' }
	-- use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }   
	--[[
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' } 
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }        -- buffer auto-completion
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }          -- path auto-completion
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }       -- cmdline auto-completion
	use { 'hrsh7th/cmp-nvim-lsp' } ]]--
    use { "catppuccin/nvim", as = "catppuccin" }
	use { "L3MON4D3/LuaSnip" }
  --[[ use({
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
}) 
    use 'saadparwaiz1/cmp_luasnip'
	]]--
   -- use {'edluffy/hologram.nvim'}
    -- You can alias plugin names
    use {'dracula/vim', as = 'dracula'}
    -- Superuser's recs
use {
    's1n7ax/nvim-terminal',
    config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
    end,
}
    use 'mechatroner/rainbow_csv'
    use 'godlygeek/tabular'
    -- use 'simrat39/rust-tools'
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-tree/nvim-web-devicons'
    use 'projekt0n/github-nvim-theme'
--    use 'nvim-tree/nvim-tree.lua'
   use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require("nvim-tree").setup {}
  end
}  
   -- Lua
use {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
}
	use { 'RaafatTurki/hex.nvim' }
    use {'romgrk/barbar.nvim', requires  = 'nvim-tree/nvim-web-devicons'}
    use 'voldikss/vim-floaterm'
    -- use 'nvim-telescope/telescope.nvim'
	use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'} }
}
  --  use 'vimwiki/vimwiki'
    use 'echasnovski/mini.indentscope' 
    use 'MunifTanjim/nui.nvim'
    use 'rcarriga/nvim-notify'
--    use 'folke/noice.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'chaimleib/vim-renpy'

	--nvim-cmp
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'saadparwaiz1/cmp_luasnip'}
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'rafamadriz/friendly-snippets' }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
