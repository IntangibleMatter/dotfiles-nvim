-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("hex").setup()

require("nvim-tree").setup({})

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<leader>]", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

-- pass to setup along with your other options
require("nvim-tree").setup({
	---
	update_cwd = true,
	on_attach = my_on_attach,
	---
})

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	-- keymaps
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map("n", "<leader>gs", gs.stage_hunk, { desc = "stage hunk" })
		map("n", "<leader>gr", gs.reset_hunk, { desc = "reset hunk" })
		map("v", "<leader>gs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "stage hunk" })
		map("v", "<leader>gr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "reset hunk" })
		map("n", "<leader>gS", gs.stage_buffer, { desc = "stage buffer" })
		map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
		map("n", "<leader>gR", gs.reset_buffer, { desc = "reset buffer" })
		map("n", "<leader>gp", gs.preview_hunk, { desc = "preview hunk" })
		map("n", "<leader>gb", function()
			gs.blame_line({ full = true })
		end, { desc = "blame line" })
		map("n", "<leader>gt", gs.toggle_current_line_blame, { desc = "toggle current line blame" })
		map("n", "<leader>gd", gs.diffthis, { desc = "diff this" })
		map("n", "<leader>gD", function()
			gs.diffthis("~")
		end, { desc = "diff this ~" })
		map("n", "<leader>gx", gs.toggle_deleted, { desc = "toggle deleted" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

require("focus").setup({
	enable = true,
	commands = true,
	autoresize = {
		enable = true,
		width = 0,
		height = 0,
		minwidth = 0,
		minheight = 0,
		height_quickfix = 10,
	},
	split = {
		bufnew = false,
		tmux = false,
	},
	ui = {
		number = false,
		relativenumber = false,
		hybridnumber = false,
		absolutenumber_unfocussed = false,

		cursorline = true,
		cursorcolumn = false,
		colorcolumn = {
			enable = false,
			list = "+1",
		},
		signcolumg = true,
		winhighlight = false,
	},
})

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "po", "rust" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

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
local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = { "haxe" }, -- Install the Haxe parser
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
})
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
		hxc = "haxe",
	},
})
-- lua
require("nvim-tree").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})
require("telescope").load_extension("projects")

-- run this command to create the lisp thing
-- !sbcl sbcl --load /home/intangible/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp
--[[
vim.g.barbar_auto_setup = false

require("barbar").setup({
	animation = true,

	auto_hide = false,

	tabpages = true,

	clickable = true,

	focus_on_close = "left",

	icons = {
		-- Configure the base icons on the bufferline.
		-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
		buffer_index = false,
		buffer_number = false,
		button = "",
		-- Enables / disables diagnostic symbols
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
			[vim.diagnostic.severity.WARN] = { enabled = false },
			[vim.diagnostic.severity.INFO] = { enabled = false },
			[vim.diagnostic.severity.HINT] = { enabled = true },
		},
		gitsigns = {
			added = { enabled = true, icon = "+" },
			changed = { enabled = true, icon = "~" },
			deleted = { enabled = true, icon = "-" },
		},
		filetype = {
			-- Sets the icon's highlight group.
			-- If false, will use nvim-web-devicons colors
			custom_colors = false,

			-- Requires `nvim-web-devicons` if `true`
			enabled = true,
		},
		separator = { left = "▎", right = "" },

		-- If true, add an additional separator at the end of the buffer list
		separator_at_end = true,

		-- Configure the icons on the bufferline when modified or pinned.
		-- Supports all the base icon options.
		modified = { button = "●" },
		pinned = { button = "", filename = true },

		-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
		preset = "default",

		-- Configure the icons on the bufferline based on the visibility of a buffer.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		alternate = { filetype = { enabled = false } },
		current = { buffer_index = true },
		inactive = { button = "×" },
		visible = { modified = { buffer_number = false } },
	},
	-- hide = {extensions = true, inactive = true ),

	sidebar_filetypes = {
		NvimTree = true,
	},
})]]
--
