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
    branch = "dev",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "Document Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle focus=true<cr>", desc = "Quickfix" },
      { "<leader>xl", "<cmd>Trouble loclist toggle focus=true<cr>", desc = "Loclist" },
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
        "lua_ls",
        "clangd",
        "rust_analyzer",
        "gopls",
        "tsserver",
        "eslint",
        "jsonls",
        "solargraph",
        "rubocop",
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
}
