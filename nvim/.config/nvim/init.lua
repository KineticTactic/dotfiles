vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'nosplit'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99

vim.o.winblend = 10

-- Sync clipboard between OS and Neovim.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

require('config.pack').setup()

require 'plugins.specs'
require 'plugins.guess-indent'
require 'plugins.gitsigns'
require 'plugins.which-key'
require 'plugins.gruvbox'
require 'plugins.todo-comments'
require 'plugins.mini'
require 'plugins.conform'
require 'plugins.blink'
-- require 'plugins.treesitter'
require 'plugins.neoscroll'
require 'plugins.flash'
require 'plugins.cord'

require('config.keymaps').setup()
require 'config.lsp'
require 'config.diagnostics'
require 'config.autocmds'
