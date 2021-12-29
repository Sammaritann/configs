require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "cmake", "lua", "haskell", "vim", "markdown", "query", "bash", "glsl" },
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.filetype.add { extension = { vert = 'glsl', frag = 'glsl' } }
