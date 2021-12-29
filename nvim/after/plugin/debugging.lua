------------------------- Setting up DAP client -------------------------

-- Instruction: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)

local dap = require('dap')

vim.api.nvim_create_user_command(
  'DapResetSizes',
  function(opts)
    require('dapui').open({ reset = true })
  end,
  { desc = "Restores dapui windows to their original size" }
)

-- Last selected debug target
-- e.g. "bin/a.out"
dap_last_debug_target = ""

-- TODO Add CMake targets selection
function SelectDebugTarget()
  -- Faster and less user-friendly alternative:
  dap_last_debug_target = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  do return end

  local pickers = require("telescope.pickers")
  local previewers = require("telescope.previewers")
  local finders = require("telescope.finders")
  local config = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local builtin = require("telescope.builtin")

  -- TODO Set picker initial value
  builtin.find_files({
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
    previewer = false,
    results_title = "Select debug target",
    default_text = dap_last_debug_target,
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        dap_last_debug_target = selection.value
      end)
      return true
    end
  })
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  -- Using adapter from https://github.com/microsoft/vscode-cpptools
  command = 'OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      if dap_last_debug_target == nil or dap_last_debug_target == "" then
        dap_last_debug_target = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end
      return dap_last_debug_target
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },

  --[[
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
  --]]
}

-- Same config in c and rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

------------------------- Setting up DAP client UI -------------------------

-- Font fix: https://askubuntu.com/a/737285

local dapui = require("dapui")

require("dapui").setup({
  icons = { expanded = "⬐", collapsed = "→", current_frame = "→" },

  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        --"stacks",
        --"watches",
      },
      size = 60, -- 60 columns
      position = "left",
    },

    {
      elements = {
        "stacks"
      },
      size = 0.25,
      position = "bottom",
    },

    --[[
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
    ]]--
  },

  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "⏸",
      play = "▶",
      step_into = "↓",
      step_over = "↷",
      step_out = "↑",
      step_back = "↶",
      run_last = "⦿",
      terminate = "⨯",
    },
  },

  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },

  windows = { indent = 1 },

  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

-- Open and close debugging interface automatically:
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
--  TODO FIX: Autoclosing does not work
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local map = require("buzreps.remap")
-- map.normal { '<F1>', ":lua require('dap').step_into()<CR>" }
-- map.normal { '<F2>', ":lua require('dap').step_over()<CR>" }
-- map.normal { '<F3>', ":lua require('dap').step_out()<CR>" }
-- map.normal { '<F5>', ":lua require('dap').continue()<CR>" }
-- map.normal { '<Leader><F5>', SelectDebugTarget }
-- map.normal { '<F6>', ":lua require('dap').terminate()<CR>" }
-- map.normal { '<F7>', ":lua require('dapui').toggle()<CR>" }
-- map.normal { '<F8>', ":lua require('dap').focus_frame()<CR>" }
-- map.normal { '<Leader>bt', ":lua require('dap').toggle_breakpoint()<CR>" }
-- map.normal { '<Leader>bc', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" }
-- map.normal { '<Leader>lp', ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" }
-- map.normal { '<Leader>dr', ":lua require('dap').repl.open()<CR>" }
-- map.normal { '<Leader>dr', ":lua require('dap').run_last()<CR>" }
