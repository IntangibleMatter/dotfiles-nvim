-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require('nvim-tree').setup()

--[[
-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_setup = true,
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

local function open_nvim_tree()

  -- open the tree
  require("nvim-tree.api").tree.open()
end

]]--