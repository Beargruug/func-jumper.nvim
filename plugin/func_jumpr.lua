local func_jumpr = require("func_jumpr")

-- Create a command to toggle the plugin
vim.api.nvim_create_user_command("FuncJumperToggle", func_jumpr.toggle, {})
