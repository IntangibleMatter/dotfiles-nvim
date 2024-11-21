vim.lsp.start({
	name = "cl-lsp",
	cmd = { "cl-lsp" },
	root_dir = vim.fs.dirname(vim.fs.find({ "." }, { upward = true })[1]),
})
vim.cmd("setlocal tabstop=2") -- number of visual spaces per TAB
vim.cmd("setlocal softtabstop=2") -- number of spacesin tab when editing
vim.cmd("setlocal shiftwidth=2") -- insert 2 spaces on a tab
