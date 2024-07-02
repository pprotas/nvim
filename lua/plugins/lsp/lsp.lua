return {
  { "folke/neodev.nvim", lazy = true, config = true },
  {
    "folke/neoconf.nvim",
    lazy = true,
    opts = {
      plugins = {
        lua_ls = { enabled = true },
      },
    },
  },
  { "j-hui/fidget.nvim", lazy = true },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
    keys = {
      { "<leader>cc", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "Document diagnostics" },
      { "<leader>cC", "<cmd>Trouble diagnostics toggle focus=true<cr>",              desc = "Workspace diagnostics" },
      { "<leader>cq", "<cmd>Trouble quickfix toggle focus=true<cr>",                 desc = "Quickfix" },
      { "<leader>cl", "<cmd>Trouble loclist toggle focus=true<cr>",                  desc = "Loclist" },
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = {
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      separator = "  ",
      click = true,
      depth_limit = 4,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
      "folke/neoconf.nvim",
      "folke/neodev.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- LSP settings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.diagnostic.config({
            severity_sort = true,
            float = {
              border = "rounded",
              source = "if_many",
            },
            virtual_text = {
              spacing = 4,
              source = "if_many",
              prefix = "●",
            },
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.HINT] = " ",
                [vim.diagnostic.severity.INFO] = " ",
              },
            },
          })

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

            if client.supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable()
            end
          end
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = "hrsh7th/cmp-nvim-lsp",
    opts = {
      ensure_installed = {
        "typos_lsp",
        "emmet_language_server",
        "lua_ls",
        "clangd",
        "rust_analyzer",
        "gopls",
        "tsserver",
        "eslint",
        "jsonls",
        "solargraph",
        "rubocop",
        "markdown_oxide",
      },
    },
    config = function(_, opts)
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup(opts)

      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities =
          vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["tsserver"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.tsserver.setup({
            capabilities = capabilities,
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "/home/pawel/.local/share/nvim/mason/bin/node_modules/@vue/typescript-plugin",
                  languages = { "vue" },
                },
              },
              preferences = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
                importModuleSpecifierPreference = "non-relative",
              },
            },
            filetypes = {
              "javascript",
              "typescript",
              "javascriptreact",
              "typescriptreact",
              "vue",
            },
          })
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                hint = { enable = true },
                codeLens = {
                  enable = true,
                },
              },
            },
          })
        end,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "stylua",
        "clang-format",
        "gersemi",
        "gdformat",
      },
    },
  },
}
