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
    "folke/ts-comments.nvim",
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
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      delay = 200,
      providers = { "lsp" },
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
