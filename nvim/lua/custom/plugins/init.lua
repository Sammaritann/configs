return {
  -- Syntax parser. Required for many plugins
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.2',
    build = ':TSUpdate'
  },

  -- Fuzzy finder over lists of anything
  -- Optionaly requires github.com/BurntSushi/ripgrep for live_grep
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- Generic lua tools required for nvim-telescope
      'nvim-lua/plenary.nvim',
    }
  },

  'preservim/nerdtree',

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },


  -- Language Server Protocol (LSP) config
  -- Requires external LSP servers
  'neovim/nvim-lspconfig',

  -- Autocompletion engine
  'hrsh7th/nvim-cmp',
  -- Language server symbols suggestions (types, functions, variables)
  'hrsh7th/cmp-nvim-lsp',
  -- Show function arguments description as suggestions
  'hrsh7th/cmp-nvim-lsp-signature-help',
  -- Buffer words suggestions
  'hrsh7th/cmp-buffer',
  -- Filesystem paths suggestions
  'hrsh7th/cmp-path',
  -- Commands suggestions
  'hrsh7th/cmp-cmdline',
  -- LSP snippets suggestions
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = {
      -- Snippet expansion plugins (LSP can return snippets for completion)
      'L3MON4D3/LuaSnip',
    }
  },

  -- Debug Adapter Protocol (DAP) client implementation
  -- Requires external DAP servers
  'mfussenegger/nvim-dap',
  -- Additional sources for telescope
  -- :Telescope dap list_breakpoints|variables|frames
  'nvim-telescope/telescope-dap.nvim',
  -- DAP UI: threads, stacktrace, scopes, variables windows
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'nvim-neotest/nvim-nio',
    }
  },
  -- Show variables values next to their definitions
  -- TODO enable
  --[[
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  ]] --

  -- Document symbols outline drawer (requires LSP)
  'simrat39/symbols-outline.nvim',

  -- Markdown tools (e.g. :Toc for table of contents drawer)
  'preservim/vim-markdown',

  'NvChad/nvim-colorizer.lua',
}
