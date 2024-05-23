-- Toggling relative numbers outside of insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd("set norelativenumber")
  end,
  pattern = "*",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.cmd("set relativenumber")
  end,
  pattern = "*",
})

-- Make lazygit interactable once it's opened in a terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*lazygit*",
  callback = function()
    vim.cmd("startinsert")
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

vim.api.nvim_create_autocmd("TermOpen", {
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

-- Conceallevel
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "markdown",
  },
  callback = function()
    vim.o.conceallevel = 2
  end,
})

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP keybinds
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references focus=true<cr>", { buffer = args.buf })
    vim.keymap.set("n", "crn", vim.lsp.buf.rename, { buffer = args.buf })
    vim.keymap.set({ "n", "v" }, "crr", vim.lsp.buf.code_action, { buffer = args.buf })
  end,
})

-- LSP capabilities
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client then
      if client.name == "eslint" then
        client.server_capabilities.documentFormattingProvider = true
      elseif client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
      end
      if vim.version().minor > 10 then
        if client.supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable()
        end
      end
      -- if client.supports_method("textDocument/codeLens") then
      --   vim.lsp.codelens.refresh()
      --   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      --     buffer = args.buf,
      --     callback = vim.lsp.codelens.refresh,
      --   })
      -- end
    end
  end,
})

-- Linting
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Indentscope toggling
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "alpha",
    "dashboard",
    "neo-tree",
    "Trouble",
    "trouble",
    "lazy",
    "mason",
    "notify",
    "toleterm",
    "lazyterm",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
