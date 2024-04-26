local function augroup(name)
  return vim.api.nvim_create_augroup("pvim_" .. name, { clear = true })
end

local number_toggle = augroup("relativenumber")

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd("set norelativenumber")
  end,
  group = number_toggle,
  pattern = "*",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.cmd("set relativenumber")
  end,
  group = number_toggle,
  pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q_custom"),
  pattern = {
    "help",
    "lspinfo",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "checkhealth",
    "fugitiveblame",
    "oil",
    "health",
    "lazy"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("conceallevel"),
  pattern = {
    "markdown",
  },
  callback = function()
    vim.o.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = args.buf })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = args.buf })
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    vim.keymap.del('n', '<leader>cr', { buffer = args.buf })
    vim.keymap.del({ 'n', 'v' }, '<leader>ca', { buffer = args.buf })
    vim.keymap.del('n', 'K', { buffer = args.buf })
    vim.keymap.del('n', 'gd', { buffer = args.buf })
    vim.keymap.del('n', 'gr', { buffer = args.buf })
  end,
})
