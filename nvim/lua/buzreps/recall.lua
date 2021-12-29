local M = {}

local current_entry = {}
local recall_entries = {}

M.refresh_recall_entry = function()
  local entries = recall_entries[math.random(1, #recall_entries)]
  current_entry = entries[math.random(1, #entries)]
end

M.get_current_recall_entry = function()
  current_entry = current_entry or {}
  current_entry.text = current_entry.text or ""
  current_entry.descr = current_entry.descr or ""
  current_entry.category = current_entry.category or "thing"
  current_entry[vim.type_idx] = vim.types.dictionary
  return current_entry
end

-- Check if the file exists
local file_exists = function(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Get all lines from a file, returns an empty
-- list/table if the file does not exist
local read_lines = function(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    local valid =
        line ~= nil and
        line ~= '' and
        line[1] ~= '#'
    if valid then
      lines[#lines + 1] = line
    end
  end
  return lines
end

local load_entries = function(filepath, parser, category)
  local entries = {}
  local lines = read_lines(filepath)
  for line_num, line in pairs(lines) do
    local entry = parser(line)
    if entry ~= nil then
      entry.category = category
      table.insert(entries, entry)
    end
  end
  vim.print("Recaller: Read " .. #entries .. " entries from " .. filepath)
  return entries
end

local start_worker = function()
  local uv = require("luv")
  local update_timer = uv.new_timer()
  local refresh_time_sec = 60
  update_timer:start(0, refresh_time_sec * 1000, vim.schedule_wrap(function()
    M.refresh_recall_entry()
    vim.cmd("redrawstatus")
  end))
end

local get_user_mappings = function()
  local mappings = require("buzreps.remap").get_all_mappings()
  local entries = {}
  for idx, mapping in ipairs(mappings) do
    local entry = { text = mapping[2], descr = mapping.descr }
    if not entry.descr and type(mapping[3]) == "string" then
      entry.descr = mapping[3]
    end
    entry.category = "User mapping"
    table.insert(entries, entry)
  end
  return entries
end

local init = function()
  local config_dir = vim.fn.stdpath("config")
  local tab_separated = function(line)
    local res = {}
    for text, descr in string.gmatch(line, "(.*)\t+(.*)") do
      res = { text = text, descr = descr }
    end
    return res
  end
  local single_string = function(line)
    return { text = line }
  end

  --table.insert(recall_entries, load_entries(config_dir .. "/res/ex.txt", tab_separated, "Vim Ex commands"))
  --table.insert(recall_entries, load_entries(config_dir .. "/res/window.txt", tab_separated, "Vim window command"))
  --table.insert(recall_entries, get_user_mappings())
  table.insert(recall_entries, load_entries(config_dir .. "/res/cpp_index.txt", single_string, "C++ feature"))
  table.insert(recall_entries, load_entries(config_dir .. "/res/opengl_4_5.txt", single_string, "OpenGL 4.5 feature"))
  table.insert(recall_entries, load_entries(config_dir .. "/res/qt_6_core.txt", single_string, "Qt feature"))

  start_worker()
  vim.api.nvim_create_user_command(
    'ShowRecallAnswer',
    function(opts)
      vim.print(current_entry.descr)
    end,
    { desc = "Prints the answer to current recall entry" }
  )
end

if BUZ_RECALL_INITIALIZED == nil then
  init()
  BUZ_RECALL_INITIALIZED = {}
end

return M
