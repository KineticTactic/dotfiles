local M = {}
local pick = require 'mini.pick'
local extra = require 'mini.extra'

function M.setup()
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Keybinds to make split navigation easier.
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
  vim.keymap.set('n', '<leader>wh', '<C-w>H', { desc = 'Move window to the left' })
  vim.keymap.set('n', '<leader>wl', '<C-w>L', { desc = 'Move window to the right' })
  vim.keymap.set('n', '<leader>wj', '<C-w>J', { desc = 'Move window to the lower' })
  vim.keymap.set('n', '<leader>wk', '<C-w>K', { desc = 'Move window to the upper' })

  vim.keymap.set('n', '<leader>r', require('config.run').run_project, { desc = '[R]un project' })

  vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Write' })
  vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open file explorer' })

  vim.keymap.set('n', '<leader>sf', pick.builtin.files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sg', pick.builtin.grep_live, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader><leader>', pick.builtin.buffers, { desc = 'Find existing buffers' })
  vim.keymap.set('n', '<leader>sh', pick.builtin.help, { desc = '[S]earch [H]elp' })
  -- vim.keymap.set('n', '<leader>sc', pick.builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader>/', pick.builtin.grep_live, {
    desc = '[/] Fuzzily search current buffer',
  })

  -- Format
  vim.keymap.set('n', '<leader>f', function()
    require('conform').format {
      async = true,
      lsp_format = 'fallback',
    }
  end, {
    desc = '[F]ormat buffer',
  })

  -- Quickfix
  vim.keymap.set('n', '<leader>co', '<cmd>copen<CR>', { desc = 'Open quickfix' })
  vim.keymap.set('n', '<leader>cc', '<cmd>cclose<CR>', { desc = 'Close quickfix' })
  vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix' })
  vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous quickfix' })

  -- FLASH
  local flash = require 'flash'
  vim.keymap.set({ 'n', 'x', 'o' }, 's', function() flash.jump() end, { desc = 'Flash' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
  vim.keymap.set('c', '<C-s>', function() flash.toggle() end, { desc = 'Toggle Flash Search' })
end

function M.lsp(event)
  local buf = event.buf
  vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {
    buffer = buf,
    desc = '[G]oto [D]efinition',
  })

  vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, {
    buffer = buf,
    desc = '[G]oto [D]eclaration',
  })

  -- References
  vim.keymap.set('n', 'grr', function() extra.pickers.lsp { scope = 'references' } end, { buffer = buf, desc = '[G]oto [R]eferences' })

  -- Implementations
  vim.keymap.set('n', 'gri', function() extra.pickers.lsp { scope = 'implementation' } end, { buffer = buf, desc = '[G]oto [I]mplementation' })

  -- Diagnostics
  vim.keymap.set(
    'n',
    'gre',
    function()
      vim.diagnostic.open_float(nil, {
        scope = 'cursor',
        focus = false,
      })
    end,
    { desc = '[G]oto Diagnostic [E]rror' }
  )

  -- Auto indent when inserting on new line
  vim.keymap.set('n', 'i', function()
    if vim.fn.getline '.' == '' then return '"_cc' end
    return 'i'
  end, { expr = true })

  -- Toggle inlay hints
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client:supports_method('textDocument/inlayHint', event.buf) then
    vim.keymap.set(
      'n',
      '<leader>th',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
      { buffer = buf, desc = '[T]oggle Inlay [H]ints' }
    )
  end

  -- Incremental selection using built-in Tree-sitter (Neovim 0.12+)
  vim.keymap.set({ 'n', 'x', 'o' }, '<CR>', function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      require('vim.treesitter._select').select_parent(vim.v.count1)
    else
      vim.lsp.buf.selection_range(vim.v.count1)
    end
  end, {
    desc = 'Expand selection',
  })

  vim.keymap.set({ 'n', 'x', 'o' }, '<BS>', function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      require('vim.treesitter._select').select_child(vim.v.count1)
    else
      vim.lsp.buf.selection_range(-vim.v.count1)
    end
  end, {
    desc = 'Shrink selection',
  })

  -- vim.keymap.set("o", "r", function()
  --   flash.remote()
  -- end, { desc = "Remote Flash" })
  --
  -- vim.keymap.set({ "o", "x" }, "R", function()
  --   flash.treesitter_search()
  -- end, { desc = "Treesitter Search" })
end

-- markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('v', '<C-b>', 'c**<C-r>"**<Esc>', {
      buffer = true,
      desc = 'Bold selection',
    })

    vim.keymap.set('v', '<C-i>', 'c*<C-r>"*<Esc>', {
      buffer = true,
      desc = 'Italicize selection',
    })
  end,
})

-- markdown preview
vim.keymap.set("n", "<leader>md", "<cmd>MdRender toggle<CR>", {
    desc = "Toggle Markdown rendering",
})

return M
