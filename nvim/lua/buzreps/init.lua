local config_dir = vim.fn.stdpath("config")
vim.cmd('source ' .. config_dir .. '/common.vim')
vim.cmd('source ' .. config_dir .. '/old_init.vim')

-- Execute selected text as lua code
local GetLastSelection = function()
  local beg_char_pos = vim.fn.getpos("'<")
  local end_char_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, beg_char_pos[2] - 1, end_char_pos[2], false)
  local res = ""
  for _, line in ipairs(lines) do
    res = res .. line .. "\n"
  end
  return res
end

vim.api.nvim_create_user_command(
  'ExecuteSelectionAsLua',
  function(opts)
    local code = GetLastSelection()
    local compiled, message = loadstring(code)
    if compiled then compiled() end
  end, {
    desc = "Executes currently/last selected code as lua"
  }
)

local RunQmlScene = function(args)
  local filename = args.filename or (args.buf and vim.api.nvim_buf_get_name(args.buf))
  if filename then
    vim.system({ "qmlscene", filename }, { text = true })
  end
end

vim.api.nvim_create_autocmd(
  { "BufAdd", "VimEnter" }, {
    pattern = { "*.qml", "*.ui.qml" },
    callback = function(event)
      vim.api.nvim_buf_create_user_command(
        event.buf,
        'RunQmlScene',
        function(opts)
          RunQmlScene({ filename = event.file })
        end, {
          desc = "Run current QML file in qmlscene tool"
        }
      )
    end
  }
)

local ToggleDiffForCurrWindow = function()
  if vim.opt.diff:get() then
    vim.cmd('diffthis')
  else
    vim.cmd('diffoff')
  end
end

vim.api.nvim_create_user_command(
  'ToggleDiffForCurrWindow',
  ToggleDiffForCurrWindow,
  {
    desc = "Toggle diff mode for window. If two or more windows marked for diff, diff mode is shown"
  })

local my_colorscheme = require("buzreps.my_colorscheme")
my_colorscheme.enable()
