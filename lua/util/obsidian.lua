-- Utility to open Markdown notes in Obsidian
local M = {}

function M.open()
  if vim.fn.has("macunix") == 1 then
    vim.cmd("!open -g -a /Applications/Obsidian.app 'obsidian://open?vault=notes&file=%'")
    return
  end

  vim.cmd("!xdg-open 'obsidian://open?vault=notes&file=%'")
end

return M
