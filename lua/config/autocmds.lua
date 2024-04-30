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
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "lspinfo",
    "notify",
    "qf",
    "query",
    "checkhealth",
    "fugitiveblame",
    "oil",
    "health",
    "lazy",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("hide_with_<C-q>"),
  pattern = {
    "spectre_panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", function()
      vim.cmd("hide")
    end, { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("hide_with_<C-q>"),
  pattern = {
    "term://*lazygit*",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("t", "<C-q>", function()
      vim.cmd("stopinsert")
      vim.cmd("hide")
    end, { buffer = event.buf, silent = true })
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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = args.buf })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "gr", "<Cmd>Trouble lsp_references focus=true<CR>", { buffer = args.buf })

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      if client.name == "eslint" then
        client.server_capabilities.documentFormattingProvider = true
      elseif client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
      end
      if client.server_capabilities.inlayHintProvider and vim.lsp.buf.inlay_hint then
        vim.lsp.buf.inlay_hint(args.bufnr, true)
      end
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    vim.keymap.del("n", "<leader>cr", { buffer = args.buf })
    vim.keymap.del({ "n", "v" }, "<leader>ca", { buffer = args.buf })
    vim.keymap.del("n", "K", { buffer = args.buf })
    vim.keymap.del("n", "gd", { buffer = args.buf })
    vim.keymap.del("n", "gr", { buffer = args.buf })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    local is_lazygit = vim.b.is_lazygit or false
    if is_lazygit then
      vim.cmd("startinsert")
    end
  end,
})
