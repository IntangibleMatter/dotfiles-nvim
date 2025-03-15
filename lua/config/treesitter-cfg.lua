require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"kotlin",
		"query",
		"markdown",
		"po",
		"rust",
		"commonlisp",
		"arduino",
	},
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	ignore_install = {
		"tsv",
	},

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local configs = require("nvim-treesitter.configs")

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
--[[
parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.haxe = {
	install_info = {
		url = "https://github.com/vantreeseba/tree-sitter-haxe",
		files = { "src/parser.c" },
		-- optional entries:
		branch = "main",
	},
	filetype = "haxe",
}
vim.filetype.add({
extension = {
		hx = "haxe",
	},
})]]
--

--parser_config = require("nvim-treesitter.parsers").get_parser_configs()

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

-- my own misc bullshit filetypes

vim.filetype.add({
	extension = {
		ebtr = "cfg",
	},
})
