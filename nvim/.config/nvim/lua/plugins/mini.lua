require('mini.icons').setup()
require('mini.statusline').setup {
  use_icons = vim.g.have_nerd_font,

  content = {
    active = function()
      local mode = MiniStatusline.section_mode { trunc_width = 120 }

      -- Make mode one letter
      mode = mode:sub(1, 1)

      local git = MiniStatusline.section_git { trunc_width = 75 }

      local filename = MiniStatusline.section_filename {
        trunc_width = 140,
      }

      local modified = vim.bo.modified and ' ●' or ''

      local icon = MiniIcons.get('filetype', vim.bo.filetype)

      local line = vim.fn.line '.'
      local col = vim.fn.col '.'
      local location = string.format('%4d:%-3d', line, col)

      return MiniStatusline.combine_groups {
        { hl = 'MiniStatuslineModeNormal', strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git } },
        { hl = 'MiniStatuslineFilename', strings = { filename .. modified } },

        '%=',
        { hl = 'MiniStatuslineModeNormal', strings = { require('util.cat').cat_mode() } },
        { hl = 'MiniStatuslineFileinfo', strings = { icon } },
        { hl = 'MiniStatuslineDevinfo', strings = { location } },
      }
    end,
  },
}
require('mini.comment').setup { mappings = { comment_line = 'gc' } }
require('mini.pairs').setup()

require('mini.files').setup {
  windows = {
    preview = true,
    width_preview = 60,
    border = 'rounded',
  },
}
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
require('mini.notify').setup {
  window = {
    config = {
      border = 'rounded',
    },
  },
}
require('mini.pick').setup {
  mappings = {
    move_down = '<C-j>',
    move_up = '<C-k>',
  },
  window = {
    config = {
      border = 'rounded',
    },
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

require('mini.starter').setup {
  autoopen = true,

  items = {
    require('mini.starter').sections.recent_files(5, false),
    require('mini.starter').sections.recent_files(5, true),
    require('mini.starter').sections.builtin_actions(),
  },

  content_hooks = {
    require('mini.starter').gen_hook.adding_bullet '│ ',
    require('mini.starter').gen_hook.aligning('center', 'center'),
  },

  header = [[
    /\_/\                                         
   ( o.o )                                        
    > - <                                         
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  ]],

  footer = '',
}
