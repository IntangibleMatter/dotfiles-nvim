-- Utilities for creating configurations
local util = require("formatter.util")

local clangformat = function()
	return {
		exe = "clang-format",
		args = {
			"-assume-filename",
			util.escape_path(util.get_current_buffer_file_name()),
			--"-style={UseTab: Always, IndentWidth: 4, TabWidth: 4}",
		},
		stdin = true,
		--try_node_modules = true,
	}
end

local prettier = function()
	return function(parser)
		if not parser then
			return {
				exe = "prettier",
				args = {
					"--use-tabs",
					"--stdin-filepath",
					util.escape_path(util.get_current_buffer_file_path()),
				},
				stdin = true,
				try_node_modules = true,
			}
		end

		return {
			exe = "prettier",
			args = {
				"--use-tabs",
				"--stdin-filepath",
				util.escape_path(util.get_current_buffer_file_path()),
				"--parser",
				parser,
			},
			stdin = true,
			try_node_modules = true,
		}
	end
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		rust = {
			function()
				return { exe = "rustfmt", stdin = true }
			end,
		},

		-- run "pipx install gdtoolkit", make sure the install location is on the path, then run this.
		gdscript = {
			function()
				return { exe = "gdformat" }
			end,
		},

		json = {
			require("formatter.filetypes.json").fixjson,
		},

		go = {
			require("formatter.filetypes.go").gofmt,
		},

		python = {
			require("formatter.filetypes.python").autopep8,
		},

		--[[markdown = {
			--	require("formatter.filetypes.markdown").prettier,
			prettier,
		},]]
		--

		cpp = {

			clangformat,

			--require("formatter.filetypes.cpp").clangformat,
		},

		c = {
			clangformat,
			--require("formatter.filetypes.c").clangformat,
		},

		css = {
			prettier,
			--require("formatter.filetypes.css").prettier,
		},

		scss = {
			prettier,
			--require("formatter.filetypes.css").prettier,
		},

		html = {
			prettier,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])
