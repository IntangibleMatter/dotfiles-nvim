local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local configs = require("nvim-treesitter.configs")

vim.filetype.add({
	extension = {
		lspgd = "commonlisp",
		lispdot = "commonlisp",
		gdlisp = "commonlisp",
		lispgd = "commonlisp",
	},
})

vim.filetype.add({
	extension = {
		ldtk = "ldtk",
	},
})

vim.treesitter.language.register("json", "ldtk")

vim.filetype.add({
	extension = {
		p8 = "lua",
	},
})

vim.filetype.add({
	extension = {
		pde = "processing",
	},
	--[[pattern = {
		["*.pde"] = function()
			vim.bo.syntax = "java"
			return "processing"
		end,
	},]]
})

vim.treesitter.language.register("java", "processing")

vim.filetype.add({
	extension = {
		hx = "haxe",
		hxc = "haxe",
	},
})

parser_config.haxe = {
	install_info = {
		url = "https://github.com/vantreeseba/tree-sitter-haxe",
		files = { "src/parser.c", "src/scanner.c" },
		-- optional entries:
		branch = "main",
	},
	filetype = "haxe",
}

parser_config.wren = {
	install_info = {
		url = "https://github.com/otherJL0/tree-sitter-wren",
		--url = "~/Dev/grammars/tree-sitter-wren",
		files = { "src/parser.c", "src/scanner.c" },
		branch = "main",
	},
	filetype = "wren",
}

vim.filetype.add({
	extension = {
		wren = "wren",
	},
})

vim.filetype.add({
	extension = {
		ftl = "fluent",
	},
})

parser_config.fluent = {
	install_info = {
		url = "https://github.com/projectfluent/tree-sitter-fluent",
		files = { "src/parser.c" },
	},
	filetype = "fluent",
}

-- minecraft filetypes
vim.filetype.add({
	extension = {
		mcfunction = "mcfunction",
	},
})
vim.filetype.add({
	extension = {
		mcmeta = "json",
	},
})
parser_config.mcfunction = {
	install_info = {
		url = "https://github.com/theusaf/tree-sitter-mcfunction-lang",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "mcfunction",
}

vim.filetype.add({
	extension = {
		ebtr = "cfg",
	},
})

parser_config.asm6502 = {
	install_info = {
		url = "~/Dev/grammars/tree-sitter-merlin6502/", -- local path or git repo
		files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
		-- optional entries:
		branch = "main", -- default branch in case of git repo if different from master
		generate_requires_npm = false, -- if stand-alone parser without npm dependencies
		requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
	},
	filetype = "s", -- if filetype does not match the parser name
}
