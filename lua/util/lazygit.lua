-- Make lazygit interactable once it's opened in a terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*lazygit*",
  command = "startinsert"
})

-- Set a filetype so that we can hide the winbar
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*lazygit*",
  command = "set filetype=lazygit",
})

-- Hide Lazygit with <C-q>
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*lazygit*",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("t", "<C-q>", function()
      vim.cmd("stopinsert")
      vim.cmd("hide")
    end, { buffer = event.buf, silent = true })
  end,
})

-- Utility to open up `lazygit` in a terminal
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
    end,
  }

  vim.fn.termopen("lazygit", term_opts)
  vim.cmd("startinsert")
end

-- Open `lazygit` in a terminal
function M.open()
  local Process = require("lazy.manage.process")
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
