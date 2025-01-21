local dap = require("dap")

-- .NET

dap.adapters.coreclr = {
	type = "executable",
	command = "/path/to/dotnet/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
}

-- Godot
dap.adapters.godot = {
	type = "server",
	host = "127.0.0.1",
	port = 6006,
}

dap.configurations.gdscript = {
	{
		type = "godot",
		request = "launch",
		name = "Launch scene",
		project = "${workspaceFolder}",
		launch_scene = true,
	},
}

-- Korlin
dap.adapters.kotlin = {
	type = "executable",
	command = "kotlin-debug-adapter",
	options = { auto_continue_if_many_stopped = false },
}

dap.configurations.kotlin = {
	{
		type = "kotlin",
		request = "launch",
		name = "This file",
		-- may differ, when in doubt, whatever your project structure may be,
		-- it has to correspond to the class file located at `build/classes/`
		-- and of course you have to build before you debug
		mainClass = function()
			local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
			local fname = vim.api.nvim_buf_get_name(0)
			-- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
			return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
		end,
		projectRoot = "${workspaceFolder}",
		jsonLogFile = "",
		enableJsonLogging = false,
	},
	{
		-- Use this for unit tests
		-- First, run
		-- ./gradlew --info cleanTest test --debug-jvm
		-- then attach the debugger to it
		type = "kotlin",
		request = "attach",
		name = "Attach to debugging session",
		port = 5005,
		args = {},
		projectRoot = vim.fn.getcwd,
		hostName = "localhost",
		timeout = 2000,
	},
}
-- Firefox js
dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/path/to/vscode-firefox-debug/dist/adapter.bundle.js" },
}

dap.configurations.typescript = {
	{
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
		firefoxExecutable = "/usr/bin/firefox",
	},
}

-- Python
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "path/to/virtualenvs/debugpy/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}
