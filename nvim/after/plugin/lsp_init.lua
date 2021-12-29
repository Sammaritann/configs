local map = require("buzreps.remap")

local my_diagnostic_goto_opts = {
  wrap = false,
  severity = { min = vim.diagnostic.severity.HINT },
  float = { border = 'rounded', scope = 'line', },
}
map.normal {
  '<Leader>e',
  function() vim.diagnostic.goto_next(my_diagnostic_goto_opts) end,
  { noremap = true, silent = true },
  descr = "Goto next lsp error"
}
map.normal {
  '<Leader>E',
  function() vim.diagnostic.goto_prev(my_diagnostic_goto_opts) end,
  { noremap = true, silent = true },
  descr = "Goto prev lsp error"
}

-- Ideas: '⁇', '⁉', '‼', '⚠', '❌', '', 'ℹ️'
vim.fn.sign_define("DiagnosticSignError", { text = '->', texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = '->', texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = '->', texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = '->', texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
  virtual_text = {
    virt_text_pos = "right_align",
  },
  float = {
    header = "",
    source = true,
  },
})

local common_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- TODO read about omnifunc
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- TODO refactor lsp mappings
  -- TODO read about more vim.lsp.buf.* functions
  map.normal { '<Leader>q', vim.lsp.buf.hover, bufopts }
  map.insert { '<C-q>', vim.lsp.buf.hover, bufopts }
  map.normal { 'gd', vim.lsp.buf.definition, bufopts }
  map.normal { 'gD', vim.lsp.buf.declaration, bufopts }
  map.normal { '<Leader>D', vim.lsp.buf.type_definition, bufopts }
  map.normal { '<Leader>rn', vim.lsp.buf.rename, bufopts }
  map.normal { '<Leader>gr', vim.lsp.buf.references, bufopts }
  map.normal { '<Leader>ca', vim.lsp.buf.code_action, bufopts }
  map.normal { '<Leader>f', vim.lsp.buf.format, bufopts }
  -- map.normal { 'gi', vim.lsp.buf.implementation, bufopts)
  -- map.normal { '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- map.normal { '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- map.normal { '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- map.normal { '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)

  -- Saving attached to buffer lsp clients names (usually single) in buffer local variable to display them in statusline
  vim.b[bufnr]["lsp_clients"] = (function()
    local attached_clients = {}
    for _, buf in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(attached_clients, buf.name)
    end
    return table.concat(attached_clients, ", ")
  end)()
end

local common_lsp_flags = {
  debounce_text_changes = 150,
}
--
-- Tell lsp that client can autocomplete
-- Attach this caps to each server setup
local common_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP for C/C++
require('lspconfig').clangd.setup {
  -- Uncomment to enable verbose log
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
  },
  on_attach = function(client, bufnr)
    common_on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- <Leader>h now will switch between header/source
    map.normal { '<Leader>h', "<cmd>ClangdSwitchSourceHeader<CR>", bufopts }
  end,
  flags = common_lsp_flags,
  capabilities = common_capabilities,
}

-- LSP for LUA
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true,
  on_attach = common_on_attach,
  flags = common_lsp_flags,
  capabilities = common_capabilities,
}

-- LSP for Python
require('lspconfig').pyright.setup {
  single_file_support = true,
  on_attach = common_on_attach,
  flags = common_lsp_flags,
  capabilities = common_capabilities,
}

-- LSP for Haskell
require('lspconfig').hls.setup {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  on_attach = common_on_attach,
  flags = common_lsp_flags,
  capabilities = common_capabilities,
}

-- LSP for QML
require 'lspconfig'.qmlls.setup {
  on_attach = common_on_attach,
  flags = common_lsp_flags,
  capabilities = common_capabilities,
}
