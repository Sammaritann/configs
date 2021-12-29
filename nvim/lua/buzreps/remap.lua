local M = {
  -- Property that contols if added mapping should be added into registry
  ignore_registry_ = false,

  -- Registry of mappings
  -- Used for printing user hints or checking for collisions
  registry_ = {}
}

-- Add mapping
-- @param[in] args - table of given structure:
--   [1] - {mode} mapping modes. See `:hvim.keymap.set`
--   [2] - {lhs} a.k.a. mapping
--   [3] - {rhs} a.k.a. action
--   [4] - {opts}
--   descr (optional) - Short user-friendly mapping description
M.add_mapping = function(self, args)
  vim.keymap.set(unpack(args))
  -- local is_collision = (self.registry_[args[1]] and
  --   self.registry_[args[1]][args[2]] and true) or false
  -- if is_collision then
  --   vim.notify(
  --     "Found mapping collision: " .. vim.inspect(args[2]),
  --     vim.log.levels.WARN
  --   )
  -- end
  -- self.registry_[args[1]] = self.registry_[args[1]] or {}
  -- self.registry_[args[1]][args[2]] = args
end

-- Add normal mode mapping
-- @param[in] args - table of given structure:
--   [1] - {lhs} a.k.a. mapping
--   [2] - {rhs} a.k.a. action
--   [3] - {opts} parameter from vim.keymap.set
M.normal = function(args)
  table.insert(args, 1, "n")
  M:add_mapping(args)
end

-- Add visual mode mapping
M.visual = function(args)
  table.insert(args, 1, "v")
  M:add_mapping(args)
end

-- Add insert mode mapping
M.insert = function(args)
  table.insert(args, 1, "i")
  M:add_mapping(args)
end

-- Add terminal mode mapping
M.terminal = function(args)
  table.insert(args, 1, "t")
  M:add_mapping(args)
end

-- Return list of all registered mappings
M.get_all_mappings = function()
  return { unpack(registry) }
end

return M
