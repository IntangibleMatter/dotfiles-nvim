local parsers = require("nvim-treesitter.parsers")
local parser_config = require("nvim-treesitter.parsers")
local configs = require("nvim-treesitter.config")

vim.filetype.add({
	extension = {
		lspgd = "commonlisp",
		lispdot = "commonlisp",
		gdlisp = "commonlisp",
		lispgd = "commonlisp",
		ark = "commonlisp",
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

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").haxe = {
			install_info = {
				url = "https://github.com/vantreeseba/tree-sitter-haxe",
				queries = "queries",
			},
		}
	end,
})

-- parser_config.haxe = {
-- 	install_info = {
-- 		url = "https://github.com/vantreeseba/tree-sitter-haxe",
-- 		files = { "src/parser.c", "src/scanner.c" },
-- 		-- optional entries:
-- 		branch = "main",
-- 	},
-- 	filetype = "haxe",
-- }

vim.filetype.add({
	extension = {
		wren = "wren",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").wren = {
			install_info = {
				path = "~/Dev/grammars/tree-sitter-wren",
				generate = true,
			},
		}
	end,
})

-- parser_config.wren = {
-- 	install_info = {
-- 		-- url = "https://github.com/otherJL0/tree-sitter-wren",
-- 		url = "~/Dev/grammars/tree-sitter-wren",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- 	filetype = "wren",
-- }

vim.filetype.add({
	extension = {
		ftl = "fluent",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").fluent = {
			install_info = {
				url = "https://github.com/projectfluent/tree-sitter-fluent",
			},
		}
	end,
})

-- parser_config.fluent = {
-- 	install_info = {
-- 		url = "https://github.com/projectfluent/tree-sitter-fluent",
-- 		files = { "src/parser.c" },
-- 	},
-- 	filetype = "fluent",
-- }

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

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").mcfunction = {
			install_info = {
				url = "https://github.com/theusaf/tree-sitter-mcfunction-lang",
			},
		}
	end,
})

-- parser_config.mcfunction = {
-- 	install_info = {
-- 		url = "https://github.com/theusaf/tree-sitter-mcfunction-lang",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- 	filetype = "mcfunction",
-- }

vim.filetype.add({
	extension = {
		ebtr = "cfg",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").asm6502 = {
			install_info = {
				url = "~/Dev/grammars/tree-sitter-merlin6502/",
			},
		}
	end,
})

-- parser_config.asm6502 = {
-- 	install_info = {
-- 		url = "~/Dev/grammars/tree-sitter-merlin6502/", -- local path or git repo
-- 		files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
-- 		-- optional entries:
-- 		branch = "main", -- default branch in case of git repo if different from master
-- 		generate_requires_npm = false, -- if stand-alone parser without npm dependencies
-- 		requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
-- 	},
-- 	filetype = "s", -- if filetype does not match the parser name
-- }

vim.filetype.add({
	extension = {
		fs = "glsl",
	},
})

vim.filetype.add({
	extension = {
		gml = "gml", --"c",
	},
})
vim.treesitter.language.register("javascript", "gml")

vim.filetype.add({
	extension = {
		mustache = "mustache",
	},
})

--[[parser_config.mustache = {
	install_info = {
		url = "~/Dev/grammars/tree-sitter-mustache/",
		files = { "src/parser.c", "src/scanner.c" },
		branch = "main",
		generate_requires_npm = false,
		requires_generate_from_grammar = false,
	},
}]]

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").mustache = {
			install_info = {
				url = "https://github.com/TheLeoP/tree-sitter-mustache",
				queries = "queries",
			},
		}
	end,
})

-- parser_config.mustache = {
-- 	install_info = {
-- 		url = "https://github.com/TheLeoP/tree-sitter-mustache",
-- 		-- url = "~/Dev/grammars/tree-sitter-wren",
-- 		files = { "src/parser.c", "src/scanner.c" },
-- 		branch = "main",
-- 		queries = "queries",
-- 	},
-- 	filetype = "mustache",
-- }

vim.filetype.add({
	pattern = {
		[".*_SConscript"] = "sconscript",
	},
})

vim.treesitter.language.register("python", "sconscript")

vim.filetype.add({
	extension = {
		gon = "gon",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").gon = {
			install_info = {
				url = "https://github.com/IntangibleMatter/tree-sitter-gon",
				queries = "queries",
			},
		}
	end,
})

-- parser_config.gon = {
-- 	install_info = {
-- 		url = "https://github.com/IntangibleMatter/tree-sitter-gon",
-- 		files = { "src/parser.c" },
-- 		-- optional entries:
-- 		branch = "main",
-- 	},
-- 	filetype = "gon",
-- }

vim.filetype.add({
	extension = {
		yuck = "yuck",
	},
})

--supergiant filetypes
vim.filetype.add({
	pattern = {
		["*.sjson"] = "sjson",
	},
})
vim.filetype.add({
	pattern = {
		["*.map_text"] = "map_text",
	},
})

vim.treesitter.language.register("javascript", "sjson")
vim.treesitter.language.register("json", "map_text")
vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").yuck = {
			install_info = {
				url = "https://github.com/tree-sitter-grammars/tree-sitter-yuck",
				queries = "queries",
			},
		}
	end,
})

-- parser_config.yuck = {
-- 	install_info = {
-- 		url = "https://github.com/tree-sitter-grammars/tree-sitter-yuck",
-- 		files = { "src/parser.c", "src/scanner.c" },
-- 		branch = "main",
-- 		queries = "queries",
-- 	},
-- 	filetype = "yuck",
-- }

vim.filetype.add({
	extension = {
		uwu = "bottomspeak",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").bottomspeak = {
			install_info = {
				url = "https://github.com/IntangibleMatter/tree-sitter-bottomspeak",
				queries = "queries/",
			},
		}
	end,
})

-- parser_config.bottomspeak = {
-- 	install_info = {
-- 		url = "https://github.com/IntangibleMatter/tree-sitter-bottomspeak",
-- 		files = { "src/parser.c" },
-- 		-- optional entries:
-- 		branch = "main",
-- 	},
-- 	filetype = "bottomspeak",
-- }
