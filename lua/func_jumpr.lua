-- main module file
local module = require("func_jumpr.module")
local telescope = require("telescope").load_extension("func_jumpr")

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.toggle = function()
  return telescope.toggle_func_jumpr()
  -- return module.my_first_function(M.config.opt)
end

return M
