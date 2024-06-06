local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local listFuncs = require('telescope.builtin')
local parsers = require("nvim-treesitter.parsers")

-- local func_jumpr = require("func_jumpr")

---Wrapper to get treesitter root parser
---@return node|nil
local function get_root()
  local parser = parsers.get_parser()
  if parser == nil then
    return nil
  end

  return parser:parse()[1]:root()
end

local function get_function_list_of_parent(parent)
  P(parent)
  local output = {}
  local ok = false
  for _, child in ipairs(parent:children()) do
    if child:type() == "function_declaration" then
      table.insert(output, child)
      ok = true
    end
  end

  return ok, output
end

local telescope_func_jumpr = function(opts)
  opts = opts or {}
  local root = get_root()
  if root == nil then
    print("No parser")
    return {}
  end

  local ok, output = get_function_list_of_parent(root)
  local test = output
  P(test)

  if not ok then
    print("Something went wrong in the current buffer")
    return {}
  end


  pickers.new(opts or {}, {
    prompt_title = "Func Jumpr",
    finder = finders.new_table {
      results = output,
      entry_maker = function(entry)
        return entry
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map)
      -- custom mappings

      return true
    end
  }):find()
end

return require("telescope").register_extension(
  {
    exports = {
      toggle_func_jumpr = telescope_func_jumpr,
    }
  })
