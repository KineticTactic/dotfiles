local M = {}

local function in_cp_project()
  local file = vim.api.nvim_buf_get_name(0)

  for dir in vim.fs.parents(file) do
    if vim.fs.basename(dir) == 'cp' then return true end
  end

  return false
end

local function run_cp()
  vim.cmd.write()

  vim.cmd 'botright split'
  vim.cmd 'resize 12'

  vim.cmd 'terminal g++ -std=c++17 -O2 % -o %< && ./%<'

  vim.cmd.startinsert()
end

function M.run_project()
  if in_cp_project() then
    run_cp()
    return
  end

  if vim.fn.filereadable 'build.ninja' == 1 then
    run_ninja()
    return
  end

  if vim.fn.filereadable 'Cargo.toml' == 1 then
    run_cargo()
    return
  end

  if vim.fn.filereadable 'package.json' == 1 then
    run_npm()
    return
  end

  vim.notify "Don't know how to run this project."
end

return M
