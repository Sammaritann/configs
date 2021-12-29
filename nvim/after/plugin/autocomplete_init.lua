-- equal to set completeopt=menu,menuone,noselect
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  -- If items from first array are available, items from second are not shown
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

--[[
-- Set configuration for specific filetype.
cmp.setup.filetype(
  'gitcommit',
  {
    -- You can specify the `cmp_git` source if you were installed it.
    sources = cmp.config.sources(
      { { name = 'cmp_git' } },
      { { name = 'buffer' } }
    )
  }
)
--For rcarriga/cmd-dap: add in cmd.setup and uncomment filetype. 
--fix filetype names
--[[
enabled = function()
  return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      or require("cmp_dap").is_dap_buffer()
end,

cmp.setup.filetype(
  { "[dap-repl]", "dapui_watches", "dapui_hover" },
  {
    sources = {
      { name = "dap" },
    },
  }
)
]]
--

--[[
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  { '/', '?' },
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ':',
  {
    mapping = cmp.mapping.preset.cmdline(),
    view = {
      -- custom/wildmenu/native
      entries = "custom"
    },
    sources = cmp.config.sources(
      { { name = 'path' } },
      { { name = 'cmdline' } }
    )
  }
)
]]--
