local map = vim.keymap.set

-- Lazy keymap can't be set in the spec, so we set it here
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Better j/k
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Nicer <Esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Savepoints in insert mode on punctuation
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Line diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Easy diagnostic jumping
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })

-- Easy window splitting
map("n", "<leader>-", "<C-W>s", { desc = "Split", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Vsplit", remap = true })

-- Toggle format on save
map("n", "<leader>uf", function()
  vim.g.disable_autoformat = (vim.g.disable_autoformat == nil) and true or not vim.g.disable_autoformat

  vim.notify(string.format("LSP auto-format %s", vim.g.disable_autoformat and "disabled" or "enabled"))
end, { desc = "Toggle auto-format", remap = true })

-- Toggle relativenumber outside insertmode
map("n", "<leader>un", function()
  vim.g.disable_relativenumber = (vim.g.disable_relativenumber == nil) and true or not vim.g.disable_relativenumber

  if vim.g.disable_relativenumber then
    vim.cmd("set norelativenumber")
  else
    vim.cmd("set relativenumber")
  end

  vim.notify(string.format("Normie mode %s", vim.g.disable_relativenumber and "enabled" or "disabled"))
end, { desc = "Toggle normie mode", remap = true })

-- Buffer management
map("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Delete other buffers" })
map(
  "n",
  "<leader>by",
  [[<cmd>redir @* | execute 'echon expand("%")' | redir END | echo @*<cr>]],
  { desc = "Copy buffer path" }
)