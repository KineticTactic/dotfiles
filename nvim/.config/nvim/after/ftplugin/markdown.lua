vim.bo.indentexpr = 'v:lua.markdown_indent()'

function _G.markdown_indent()
  local lnum = vim.v.lnum

  local in_code = false

  for i = lnum - 1, 1, -1 do
    local line = vim.fn.getline(i)

    if line:match '^%s*```' then
      in_code = not in_code

      if in_code then break end
    end
  end

  if in_code then return vim.fn.cindent(lnum) end

  return vim.fn.indent(lnum - 1)
end
