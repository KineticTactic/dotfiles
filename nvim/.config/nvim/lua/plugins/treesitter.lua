require('nvim-treesitter').setup()

require('nvim-treesitter').install {
  'c',
  'cpp',
  'lua',
  'vim',
  'vimdoc',
  'query',
  'python',
  'rust',
  'svelte',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cpp',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'python',
    'rust',
    'svelte',
  },
  callback = function() vim.treesitter.start() end,
})
