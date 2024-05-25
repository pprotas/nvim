-- Toggling relative numbers outside of insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber"
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if not vim.g.disable_relativenumber then
      vim.cmd("set relativenumber")
    end
  end,
})


-- Closing/hiding some buffers easily
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "lspinfo",
    "notify",
    "qf",
    "query",
    "checkhealth",
    "fugitiveblame",
    "health",
    "lazy",
    "spectre_panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Lazygit
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

-- Conceallevel
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "markdown",
  },
  command = "set conceallevel=2"
})

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
