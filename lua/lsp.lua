vim.lsp.set_log_level("debug")

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- A list of servers to automatically install if they're not already installed
	ensure_installed = {
		"pylsp",
		"gopls",
		"lua_ls",
		--"rust_analyzer",
		"csharp_ls",
		"quick_lint_js",
		"marksman",
		--'gdscript',
		--		"haxe_language_server",
		--"jsonls",
		"clangd",
		--		'ccls',
	},
})
-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

lspconfig.gdscript.setup({})

lspconfig.pylsp.setup({})

-- lspconfig.haxe_language_server.setup({})

lspconfig.gopls.setup({})

lspconfig.csharp_ls.setup({})

lspconfig.marksman.setup({})
-- lspconfig.ccls.setup{}

lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	extra = {
		{
			description = "LuaLS",
			fileMatch = ".luarc.json",
			name = ".luarc.json",
			url = "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json",
		},
	},
})

-- conflict with other rust plugin
--lspconfig.rust_analyzer.setup({})

lspconfig.clangd.setup({})

--lspconfig.lua_ls.setup({})
lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/love2d/library",
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
})

lspconfig.cssls.setup({})

lspconfig.gdshader_lsp.setup({})
--[[
-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lspconfig.pylsp.setup({
    on_attach = on_attach,
})
]]
--

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs, desc)
			local opts = { buffer = true }
			if desc ~= nil then
				opts.desc = desc
			end
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		bufmap("n", "gk", "<cmd>lua vim.lsp.buf.hover()<cr>")

		-- Jump to the definition
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

		-- Jump to declaration
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

		-- Lists all the implementations for the symbol under the cursor
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

		-- Jumps to the definition of the type symbol
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

		-- Lists all the references
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

		-- Displays a function's signature information
		bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

		-- Renames all references to the symbol under the cursor
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

		-- Selects a code action available at the current cursor position
		bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

		-- Show diagnostics in a floating window
		bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

		-- Move to the previous diagnostic
		bufmap("n", "g<Up>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

		-- Move to the next diagnostic
		bufmap("n", "g<Down>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

require("luasnip.loaders.from_vscode").lazy_load()
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
local luasnip = require("luasnip")

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-f>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
		p8 = "lua",
	},
})
