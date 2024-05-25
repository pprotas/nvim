return {
  {
    "felipec/vim-sanegx",
    event = "VeryLazy",
  },
  {
    "ethanholz/nvim-lastplace",
    event = "VeryLazy",
  },
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = true,
  },
  {
    "ethanholz/nvim-lastplace",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    version = false,
    config = true,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    version = false,
    config = true,
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    version = false,
    config = true,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    cond = function()
      return vim.version().minor < 10
    end,
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      {
        "<leader>x",
        function()
          require("persistence").load()
        end,
        desc = "Resume session",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    opts = {
      delay = 200,
      providers = { "lsp" },
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      live_update = true,
    },
    keys = {
      {
        "<leader>ss",
        function()
          require("spectre").toggle()
        end,
        desc = "Search & replace",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        b = { name = "Buffer actions" },
        c = { name = "Code" },
        g = { name = "Git" },
        n = { name = "Notifications" },
        u = { name = "Toggle" },
        s = { name = "Search" },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<S-cr>"] = "actions.select_vsplit",
        ["q"] = "actions.close",
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-p>"] = false,
        ["<C-l>"] = false,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("oil").open()
        end,
        desc = "Oil",
      },
    },
  }
}
