local dap = require("dap")

dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
        detached = false,
    },
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = { "--", "list" },
	runInTerminal = false,
}

-- rust
dap.configurations.rust = {
	lldb -- different debuggers or more configurations can be used here
}

-- godot
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
