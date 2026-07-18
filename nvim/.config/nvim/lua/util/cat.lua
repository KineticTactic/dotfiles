local M = {}

function M.cat_mode()
  local mode = vim.fn.mode()

  local cats = {
    n = '(^･o･^)ﾉ”',
    i = '=^◕⩊◕^=',
    v = '=^•.•^=',
    V = '=^•.•^=',
    ['\22'] = '=^•.•^=', -- Ctrl-V
    R = '=^>.<^=',
    c = '=^o.o^=',
    t = '=^×.×^=',
  }

  return cats[mode] or '=^.^='
end

return M
