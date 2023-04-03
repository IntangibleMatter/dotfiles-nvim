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
    use 'folke/tokyonight.nvim' 
    use 'Mofiqul/dracula.nvim'
    use 'ayu-theme/ayu-vim'
--    use 'tanvirtin/monokai.nvim'

    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim'}


    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }    
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' } 
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }        -- buffer auto-completion
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }          -- path auto-completion
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }       -- cmdline auto-completion
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- You can alias plugin names
    use {'dracula/vim', as = 'dracula'}
    -- Superuser's recs
    use 's1n7ax/nvim-terminal'
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
    
    use 'folke/which-key.nvim'
    use 'goolord/alpha-nvim'
    use {'romgrk/barbar.nvim', requires  = 'nvim-tree/nvim-web-devicons'}
    use 'voldikss/vim-floaterm'
    -- use 'nvim-telescope/telescope.nvim'
    use 'vimwiki/vimwiki'
    use 'echasnovski/mini.indentscope' 
    use 'MunifTanjim/nui.nvim'
    use 'rcarriga/nvim-notify'
    use 'folke/noice.nvim'
    use 'nvim-lualine/lualine.nvim'

  
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)