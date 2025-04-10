vim.lsp.start({
	name = "cl-lsp",
	cmd = { "cl-lsp" },
	root_dir = vim.fs.dirname(vim.fs.find({ "." }, { upward = true })[1]),
})
vim.bo.tabstop = 2 -- number of visual spaces per TAB
vim.bo.softtabstop = 2 -- number of spacesin tab when editing
vim.bo.shiftwidth = 2 -- insert 2 spaces on a tab
