-- Make lazygit interactable once it's opened in a terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*lazygit*",
  command = "startinsert",
})

-- Set a filetype so that we can hide the winbar
vim.api.nvim_create_autocmd("TermEnter", {
  pattern = "term://*lazygit*",
  callback = function()
    vim.cmd("set filetype=lazygit")
    -- Disable line numbers
    vim.defer_fn(function()
      vim.cmd("set nonumber norelativenumber")
    end, 10) -- 10 ms delay to prevent rendering bugs
  end,
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
    end
    return
  end

  M.lazygit_buf = vim.api.nvim_create_buf(false, true)
  vim.cmd("vsplit")
  M.lazygit_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(M.lazygit_win, M.lazygit_buf)

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
  local ok = pcall(Process.exec, { "lazygit", "-cd" })

  if ok then
    M.toggle_lazygit()
  else
    vim.notify("Could not open LazyGit", vim.log.levels.ERROR)
  end
end

return M
