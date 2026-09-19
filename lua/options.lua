local vim = vim
local opt = vim.opt
local api = vim.api
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.lsp.set_log_level("warn")

vim.o.foldlevelstart = 99

opt.conceallevel = 0

-- from stackoverflow
-- local fd_os_release = assert(io.open("/etc/os-release"), "r")
-- local s_os_release = fd_os_release:read("*a")
-- fd_os_release:close()
-- s_os_release = s_os_release:lower()
-- local is_arch = s_os_release:match("arch")
-- local is_pop = s_os_release:match("pop")

-- if is_arch == nil then
-- 	print("is not arch")
-- else
-- 	print("is arch")
-- end

-- Hint: use `:h <option>` to figure out the meaning if needed
-- opt.clipboard = opt.clipboard + "unnamedplus"
opt.clipboard = "unnamedplus"
-- if not is_arch then
-- 	opt.clipboard = "unnamedplus" -- use system clipboard
-- else
-- opt.clipboard = "wl-copy" -- niri
-- end
-- vim.g.clipboard = "xclip"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.mouse = "a" -- allow the mouse to be used in Nvim

-- Tab
opt.tabstop = 4 -- number of visual spaces per TAB
opt.softtabstop = 4 -- number of spacesin tab when editing
opt.shiftwidth = 4 -- insert 4 spaces on a tab
opt.expandtab = false -- tabs are spaces, mainly because of python

-- UI config
opt.number = true -- show absolute number
opt.relativenumber = true -- add numbers to each line on the left side
opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
opt.splitbelow = true -- open new vertical split bottom
opt.splitright = true -- open new horizontal splits right
opt.termguicolors = true -- enabl 24-bit RGB color in the TUI
opt.showmode = true -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
opt.incsearch = true -- search as characters are entered
opt.hlsearch = false -- do not highlight matches
opt.ignorecase = true -- ignore case in searches by default
opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- shell because for some reason it's using bash on Pop 24???
opt.shell = "fish"
