local M = {}

function M.toggle_lazygit()
  if M.lazygit_buf and vim.api.nvim_buf_is_valid(M.lazygit_buf) then
    if M.lazygit_win and vim.api.nvim_win_is_valid(M.lazygit_win) then
      vim.api.nvim_set_current_win(M.lazygit_win)
    else
      vim.cmd("vsplit")
      M.lazygit_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(M.lazygit_win, M.lazygit_buf)
      vim.wo[M.lazygit_win].number = false
      vim.wo[M.lazygit_win].relativenumber = false
    end
    return
  end

  M.lazygit_buf = vim.api.nvim_create_buf(false, true)
  vim.cmd("vsplit")
  M.lazygit_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(M.lazygit_win, M.lazygit_buf)
  vim.wo[M.lazygit_win].number = false
  vim.wo[M.lazygit_win].relativenumber = false

  local term_opts = {
    on_exit = function()
      vim.api.nvim_win_close(M.lazygit_win, true)
      M.lazygit_buf = nil
      M.lazygit_win = nil
    end
  }

  vim.fn.termopen("lazygit", term_opts)
  vim.api.nvim_buf_set_var(M.lazygit_buf, 'is_lazygit', true)
  vim.cmd("startinsert")
end

function M.open()
  local Process   = require("lazy.manage.process")
  local ok, lines = pcall(Process.exec, { "lazygit", "-cd" })

  if ok then
    local config_dir = lines[1]
    vim.env.LG_CONFIG_FILE = config_dir .. "/config.yml"
    M.toggle_lazygit()
  else
    vim.notify("Could not open LazyGit", vim.log.levels.ERROR)
  end
end

return M
