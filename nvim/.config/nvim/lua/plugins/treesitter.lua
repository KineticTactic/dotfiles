require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c',
    'cpp',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'python',
    'rust',
  },

  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,

    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
    },
  },
}
