-- Utility to open Markdown notes in Obsidian
local M = {}

function M.open()
  if vim.fn.has("macunix") == 1 then
    vim.cmd("!open -g -a /Applications/Obsidian.app 'obsidian://open?vault=notes&file=%'")
    return
  end

  local file_path = vim.api.nvim_buf_get_name(0)
  local relative_path = vim.fn.fnamemodify(file_path, ":.")
  vim.cmd("!xdg-open 'obsidian://open?vault=notes&file=" .. relative_path .. "'")
end

return M
