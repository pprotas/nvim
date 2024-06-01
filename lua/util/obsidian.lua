-- Utility to open Markdown notes in Obsidian
local M = {}

function M.open()
  vim.cmd("!xdg-open 'obsidian://open?vault=notes&file=%'")
end

return M
