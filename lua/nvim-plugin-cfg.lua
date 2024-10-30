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

--require("dap").setup({})

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
	--[[yadm = {
		enable = false,
	},]]
	--
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
	ignore_install = {
		"tsv",
	},

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
--[[configs.setup({
	ensure_installed = { "haxe" }, -- Install the Haxe parser
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
})]]
--
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
-- minecraft filetypes

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
		mcfunction = "mcfunction",
	},
})

vim.filetype.add({
	extension = {
		mcmeta = "json",
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
local telescope = require("telescope")
telescope.load_extension("projects")
telescope.load_extension("pomodori")

require("crates").setup()

-- require("rainbow-delimiters").setup()

require("ibl").setup()

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup({ scope = { highlight = highlight } })

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

--[[
require("obsidian").setup({
	workspaces = {
		{
			name = "wiki",
			path = "~/Documents/vaults/wiki",
		},
		{
			name = "personal",
			path = "~/Documents/vaults/personal",
		},
		{
			name = "school",
			path = "~/Documents/vaults/school",
		},
		{
			name = "gamedev",
			path = "~/Documents/vaults/gamedev",
		},
	},
	completion = {
		nvim_cmp = true,
	},

	mappings = {
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		["<leader>ob"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
	},
	["<CR>"] = {
		action = function()
			return require("obsidian").util.smart_action()
		end,
		opts = { buffer = true, expr = true },
	},

	--[[	note_id_func = function(title)
		local suffix = ""
		-- If title is given, transform it into valid file name.
		if title ~= nil then
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			suffix = "UNNAMED"
		end
	end,]
	--
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		local date = os.date("%Y-%m-%d")

		return date .. "-" .. suffix .. "-" .. string.sub(tostring(os.time()), -4)
	end,
})
]]
--
require("pomo").setup({
	update_interval = 1000,

	notifiers = {
		{
			name = "Default",
			opts = {
				title_icon = "󱎫",
				text_icon = "󰄉",
			},
		},

		{ name = "System" },
	},

	timers = {},

	sessions = {
		work = {
			{ name = "Work", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Work", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Work", duration = "25m" },
			{ name = "Long Break", duration = "15m" },
		},
	},
})

require("overseer").setup()

require("treesitter-context").setup()

require("remote-nvim").setup()

--require("rainbow_csv").setup()

--require("csvview").setup()

require("easytables").setup()

require("markview").setup({
	__inside_code_block = false,

	buf_ignore = {
		"nofile",
		"lua",
		"html",
	},

	debounce = 50,

	filetypes = { "markdown", "quarto", "rmd" },

	highlight_groups = "dynamic",
	injections = {
		enable = true,

		languages = {
			--- Key is the language
			markdown = {
				enable = true,

				--- When true, other injections are replaced
				--- with the ones provided here
				override = false,

				query = [[
	                    (section
	                        (atx_heading)) @fold (#set! @fold)
	                ]],
			},
		},
	},

	initial_state = true,

	max_file_length = 1000,

	modes = { "n", "no", "c" },

	render_distance = 100,

	split_conf = {
		split = "right",
	},

	block_quotes = {
		enable = true,

		--- Default configuration for block quotes.
		default = {
			--- Text to use as border for the block
			--- quote.
			--- Can also be a list if you want multiple
			--- border types!
			---@type string | string[]
			border = "▋",

			--- Highlight group for "border" option. Can also
			--- be a list to create gradients.
			---@type (string | string[])?
			hl = "MarkviewBlockQuoteDefault",
		},

		--- Configuration for custom block quotes
		callouts = {
			{
				--- String between "[!" & "]"
				---@type string
				match_string = "ABSTRACT",

				--- Primary highlight group. Used by other options
				--- that end with "_hl" when their values are nil.
				---@type string?
				hl = "MarkviewBlockQuoteNote",

				--- Text to show in the preview.
				---@type string
				preview = "󱉫 Abstract",

				--- Highlight group for the preview text.
				---@type string?
				preview_hl = nil,

				--- When true, adds the ability to add a title
				--- to the block quote.
				---@type boolean
				title = true,

				--- Icon to show before the title.
				---@type string?
				icon = "󱉫 ",

				---@type string | string
				border = "▋",

				---@type (string | string[])?
				border_hl = nil,
			},
		},
	},

	checkboxes = {
		enable = true,

		checked = {
			text = "✔",
			hl = "MarkviewCheckboxChecked",
			scope_hl = nil,
		},

		unchecked = {

			text = "✘",
			hl = "MarkviewCheckboxUnchecked",
			scope_hl = nil,
		},
	},

	code_locks = {
		enable = true,
		icons = "internal",
		style = "language",
		hl = "MarkviewCode",
		info_hl = "MarkviewCodeInfo",

		--		min_width = 60,
		pad_char = "	",
		language_names = nil,
		language_direction = "right",

		sign = true,
		sign_hl = true,
	},

	footnotes = {
		enable = true,
		superscript = true,
		hl = "Special",
	},

	headings = {
		enable = true,
		shift_width = 1,
	},

	horizontal_rules = {
		enable = true,
	},

	latex = {
		enable = true,
		brackets = {
			enable = true,

			--- Highlight group for the ()
			---@type string
			hl = "@punctuation.brackets",
		},

		--- LaTeX blocks renderer
		block = {
			enable = true,

			--- Highlight group for the block
			---@type string
			hl = "Code",

			--- Virtual text to show on the bottom
			--- right.
			--- First value is the text and second value
			--- is the highlight group.
			---@type string[]
			text = { " LaTeX ", "Special" },
		},

		--- Configuration for inline LaTeX maths
		inline = {
			enable = true,
		},

		--- Configuration for operators(e.g. "\frac{1}{2}")
		operators = {
			enable = true,
			configs = {
				sin = {
					--- Configuration for the extmark added
					--- to the name of the operator(e.g. "\sin").
					---
					--- see `nvim_buf_set_extmark()` for all the
					--- options.
					---@type table
					operator = {
						conceal = "",
						virt_text = { { "𝚜𝚒𝚗", "Special" } },
					},

					--- Configuration for the arguments of this
					--- operator.
					--- Item index is used to apply the configuration
					--- to a specific argument
					---@type table[]
					args = {
						{
							--- Extmarks are only added
							--- if a config for it exists.

							--- Configuration for the extmark
							--- added before this argument.
							---
							--- see `nvim_buf_set_extmark` for more.
							before = {},

							--- Configuration for the extmark
							--- added after this argument.
							---
							--- see `nvim_buf_set_extmark` for more.
							after = {},

							--- Configuration for the extmark
							--- added to the range of text of
							--- this argument.
							---
							--- see `nvim_buf_set_extmark` for more.
							scope = {},
						},
					},
				},
				lnot = {
					operator = {
						conceal = "",
						virt_text = { { "¬", "Special" } },
					},
				},
				land = {
					operator = {
						conceal = "",
						virt_text = { { "∧", "Special" } },
					},
				},

				lor = {
					operator = {
						conceal = "",
						virt_text = { { "∨", "Special" } },
					},
				},

				Leftrightarrow = {
					operator = {
						conceal = "",
						virt_text = { { "⇔", "Special" } },
					},
				},
				rightarrow = {
					operator = {
						conceal = "",
						virt_text = { { "→", "Special" } },
					},
				},
			},
		},

		--- Configuration for LaTeX symbols.
		symbols = {
			enable = true,

			--- Highlight group for the symbols.
			---@type string?
			hl = "@operator.latex",

			--- Allows adding/modifying symbol definitions.
			overwrite = {
				--- Symbols can either be strings or functions.
				--- When the value is a function it receives the buffer
				--- id as the parameter.
				---
				--- The resulting string is then used.
				---@param buffer integer.
				today = function(buffer)
					return os.date("%d %B, %Y")
				end,
			},

			--- Create groups of symbols to only change their
			--- appearance.
			groups = {
				{
					--- Matcher for this group.
					---
					--- Can be a list of symbols or a function
					--- that takes the symbol as the parameter
					--- and either returns true or false.
					---
					---@type string[] | fun(symbol: string): boolean
					match = { "lim", "today" },

					--- Highlight group for this group.
					---@type string
					hl = "Special",
				},
			},
		},

		subscript = {
			enable = true,

			hl = "MarkviewLatexSubscript",
		},

		superscript = {
			enable = true,

			hl = "MarkviewLatexSuperscript",
		},
	},

	list_items = {
		enable = true,

		indent_size = 4,
	},
})

-- seems nice but I don't have the time rn
--require("multicursor-nvim").setup()
