--vim.lsp.set_log_level("debug")

local java_enabled = false

require("mason").setup({
	registries = {
		--"github:nvim-java/mason-registry",
		"github:mason-org/mason-registry",
	},
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	ensure_installed = {
		lsp = {},
		formatter = {
			"gdtoolkit",
			"mdformat",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		-- "cmake",
		-- "pylsp", -- use `pip install "python-lsp-server[all]"`
		-- "gopls",
		"lua_ls",
		-- Wht is this giving a warning? Installs fine
		--		"gdtoolkit",
		--"rust_analyzer",
		--"csharp_ls",
		"quick_lint_js",
		"marksman",
		--'gdscript',
		-- "haxe_language_server",
		--"java-language-server",
		"kotlin_language_server",
		--"jsonls",
		"clangd",
		-- "fortls",
		"tinymist",
		--"jdtls",
		--		'ccls',
	},
})

if java_enabled then
	require("java").setup({

		spring_boot_tools = {
			enable = true,
			version = "1.59.0",
		},
		java_test = {
			enable = true,
			version = "0.43.1",
		},
	})
end

--[[require("mason-lspconfig").setup({
	"haxe_language_server",
	-- A list of servers to automatically install if they're not already installed
})]]
-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
--local lspconfig = require("lspconfig")
local lsp = vim.lsp
-- TODO: make it so that inlay hints are automatically set up where possible
--[[vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			inlay_hints = { enabled = true },
		},
	},
})]]
--local lsp_defaults = lsp.util.default_config

--[[lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())]]

lsp.enable("gdscript")

vim.lsp.enable("pylsp")

--lspconfig.java_language_server.setup({})

lsp.enable("kotlin_language_server")

lsp.enable("haxe_language_server")

lsp.enable("gopls")

-- Maybe replace with Omnisharp? Should compare and see which is better
lsp.enable("csharp_ls")

lsp.enable("marksman")

lsp.enable("glsl_analyzer")

lsp.enable("cmake")

lsp.enable("html")

lsp.enable("tinymist")

-- web shit
-- is the ".setup({}) not needed anymore???"
--lspconfig.somesass_ls.setup({})
lsp.enable("somesass_ls")

--vim.lsp.enable("html") -- already added like 8 lines up lmao
lsp.enable("css_variables")

--lspconfig.fortls.setup({})
lsp.enable("fortls")
-- lspconfig.ccls.setup{}

lsp.enable("jsonls", {
	settings = {
		json = {
			--schemas = require("schemastore").json.schemas(),
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
		{
			description = "McMeta",
			fileMatch = "pack.mcmeta",
			name = "pack.mcmeta",
			url = "https://raw.githubusercontent.com/Levertion/minecraft-json-schemas/refs/heads/master/java/data/pack.mcmeta.json",
		},
	},
})

-- this until [END] is a hot fucking mess so check it out more later to see if you can clean it up
--local configs = require("lspconfig.configs")
--[[if not configs.l4sp then
	configs.l4sp = {
		default_config = {
			cmd = { "~/Dev/miscshit/lsps/LS4P/initserver.sh" },
			filetypes = { "pde", "processing" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("*.pde")
			end,
			settings = {},
		},
	}
end]]

--[[lsp.config("fennel_language_server", {
	default_config = {
		-- replace it with true path
		cmd = { "fennel-language-server" },
		filetypes = { "fennel" },
		single_file_support = true,
		-- source code resides in directory `fnl/`
		--	root_dir = lsp.util.root_pattern("fnl"),
		settings = {
			fennel = {
				workspace = {
					-- If you are using hotpot.nvim or aniseed,
					-- make the server aware of neovim runtime files.
					library = vim.api.nvim_list_runtime_paths(),
				},
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
})

lsp.enable("fennel_language_server")]]

--lspconfig.l4sp.setup({})

-- html language server add snippets

--[[local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("html", {
	capabilities = capabilities,
})
vim.lsp.config("cssls", {
	capabilities = capabilities,
})]]

vim.lsp.enable("html")
vim.lsp.enable("cssls")
-- [END] of the hot mess

-- conflict with other rust plugin
--lspconfig.rust_analyzer.setup({})

lsp.enable("clangd")

--lspconfig.lua_ls.setup({})
lsp.enable("lua_ls", {
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

--lspconfig.cssls.setup({})

lsp.enable("gdshader_lsp")

lsp.enable("ts_ls")
--[[init_options = {

		preferences = {

			includeInlayParameterNameHints = "all",

			includeInlayParameterNameHintsWhenArgumentMatchesName = true,

			includeInlayFunctionParameterTypeHints = true,

			includeInlayVariableTypeHints = true,

			includeInlayPropertyDeclarationTypeHints = true,

			includeInlayFunctionLikeReturnTypeHints = true,

			includeInlayEnumMemberValueHints = true,

			importModuleSpecifierPreference = "non-relative",
		},
	},

	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false

		client.server_capabilities.document_range_formatting = false
	end,]]

--lsp.enable("spyglassmc_language_server")

-- Java stuff
--require("java").setup()
-- if java_enabled then
lsp.enable("jdtls")
-- end

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
		bufmap("n", "g<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

		-- Selects a code action available at the current cursor position
		bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("n", "gf", "<cmd>lua vim.lsp.buf.code_action()<cr>")
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
	--[[formatting = {
		fields = { "menu", "abbr", "kind" },
	},]]
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
