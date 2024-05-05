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
    opts = {
      mappings = {
        add = "ma",
        delete = "md",
        find = "mf",
        find_left = "mF",
        highlight = "mh",
        replace = "mr",
        update_n_lines = "mn",
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
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
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      {
        "<leader>xs",
        function()
          require("persistence").load()
        end,
        mode = "n",
        desc = "Restore session",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
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
        mode = "n",
        desc = "Toggle Spectre",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
}
