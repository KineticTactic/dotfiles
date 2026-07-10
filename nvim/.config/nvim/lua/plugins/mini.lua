require('mini.icons').setup()
require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
require('mini.comment').setup { mappings = { comment_line = 'gc' } }
require('mini.pairs').setup()

require('mini.files').setup()
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    vim.keymap.set('n', '<Esc><Esc>', function() require('mini.files').close() end, {
      buffer = args.data.buf_id,
      desc = 'Close MiniFiles',
    })
  end,
})

require('mini.indentscope').setup()
require('mini.ai').setup()
require('mini.surround').setup {
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    replace = 'gsr',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    update_n_lines = 'gsn',
    suffix_last = 'gsl',
    suffix_next = 'gsN',
  },
}
require('mini.notify').setup()
require('mini.pick').setup {
  mappings = {
    move_down = '<C-j>',
    move_up = '<C-k>',
  },
}
require('mini.move').setup {
  mappings = {
    -- Move visual selection
    left = '<C-S-h>',
    down = '<C-S-j>',
    up = '<C-S-k>',
    right = '<C-S-l>',

    -- Move current line
    line_left = '<C-S-h>',
    line_down = '<C-S-j>',
    line_up = '<C-S-k>',
    line_right = '<C-S-l>',
  },
}

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup {
  snippets = {
    gen_loader.from_file(vim.fn.stdpath 'config' .. '/snippets/global.json'),
    gen_loader.from_lang(),
  },
}
