-- define common options
local opt = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>l", ":setlocal spell spelllang=en_ca<cr>", opt)
map("n", "<leader>f", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>sf", "NvimTreeFindFile", opt)
map("n", "<leader>t", ":FloatermNew<CR>", opt)

--[[ local builtin = require('telescope.builtin')
map('n', '<leader>qf', builtin.find_files, {})
map('n', '<leader>qg', builtin.live_grep, {})
map('n', '<leader>qb', builtin.buffers, {})
map('n', '<leader>qh', builtin.help_tags, {})
]]
--
map("n", "<leader>ss", ":Telescope find_files<CR>", opt)
map("n", "<leader>sg", ":Telescope live_grep<CR>", opt)
map("n", "<leader>sb", ":Telescope buffers<CR>", opt)
map("n", "<leader>sh", ":Telescope help_tags<CR>", opt)
map("n", "<leader>sp", ":Telescope projects<CR>", opt)

map("n", "<leader>hd", ":HexDump<CR>", opt)
map("n", "<leader>ha", ":HexAssemble<CR>", opt)
map("n", "<leader>hh", ":HexToggle<CR>", opt)

map("n", "<leader>b-", ":BufferPrevious<CR>", opt)
map("n", "<leader>b=", ":BufferNext<CR>", opt)

map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", opt)

map("n", "<leader>ww", ":FocusToggle<CR>", opt)
map("n", "<leader>wt", ":FocusToggleWindow<CR>", opt)
map("n", "<leader>wh", ":FocusSplitLeft<CR>", opt)
map("n", "<leader>wj", ":FocusSplitDown<CR>", opt)
map("n", "<leader>wk", ":FocusSplitUp<CR>", opt)
map("n", "<leader>wl", ":FocusSplitRight<CR>", opt)
map("n", "<leader>w=", ":FocusMaxOrEqual<CR>", opt)
map("n", "<leader>ws", function()
	require("focus").split_nicely()
end, { desc = "split nicely" })
map("n", "<leader>we", ":FocusSplitCycle<CR>", opt)
--[[
map("n", "<leader>on", ":ObsidianNew<CR>", opt)
map("n", "<leader>oqs", ":ObsidianQuickSwitch<CR>", opt)
map("n", "<leader>ot", ":ObsidianToday<CR>", opt)
map("n", "<leader>oy", ":ObsidianYesterday<CR>", opt)
map("n", "<leader>of", ":ObsidianTomorrow<CR>", opt)
map("n", "<leader>olf", ":ObsidianFollowLink<CR>", opt)
map("n", "<leader>olb", ":ObsidianBacklinks<CR>", opt)
map("n", "<leader>oll", ":ObsidianLink<CR>", opt)
map("n", "<leader>oln", ":ObsidianLinkNew<CR>", opt)
map("n", "<leader>on", ":ObsidianNew<CR>", opt)
]]
--
map("n", "<leader>cs", ":TimerShow<CR>", opt)
map("n", "<leader>ch", ":TimerHide<CR>", opt)
map("n", "<leader>cp", ":TimerPause<CR>", opt)
map("n", "<leader>cs", ":TimerShow<CR>", opt)
map("n", "<leader>cc", ":TimerStart", opt) -- to let config happen
map("n", "<leader>cgw", ":TimerSession work<CR>", opt)
map("n", "<leader>ct", function()
	require("telescope").extensions.pomodori.timers()
end, opt)

--[[
-----------------
-- Normal mode --
-----------------

 Hint: see `:h vim.map.set()`
 Better window navigation
 vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
 vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
 vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
 vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

 Resize with arrows
 delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
]]
--
