local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'NMAC427/guess-indent.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'folke/which-key.nvim',
  gh 'ellisonleao/gruvbox.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'karb94/neoscroll.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'j-hui/fidget.nvim', -- Useful status updates for LSP
  gh 'stevearc/conform.nvim',
  gh 'saghen/blink.cmp',
  gh 'vyfor/cord.nvim',
  gh 'folke/flash.nvim',
}
