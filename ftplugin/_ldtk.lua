--vim.bo.syntax = "json"
print("WHY")
--vim.cmd("filetype on")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ldtk",
	callback = function(args)
		print("why", args, args.buf)
		vim.treesitter.start(args.buf, "json")
	end,
})
