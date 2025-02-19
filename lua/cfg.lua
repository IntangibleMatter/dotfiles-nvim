local vim = vim
local opt = vim.opt
local api = vim.api
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.lsp.set_log_level("error")

vim.o.foldlevelstart = 99

opt.conceallevel = 0

--[[
vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	group = "AutoFormat",
	callback = function()
		vim.cmd("silent RustFmt")
		vim.cmd("edit")
	end,
})
]]
--
--[[
-- local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end


local autoCommands = {
    -- other autocommands
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    }
}
]]
--
--nvim_create_augroups(autoCommands)
--[[
api.nvim_create_autocmd(
	{ "BufReadPost", "FileReadPost" },
	{ pattern = "*", command = "normal zR" }
)
]]
--
