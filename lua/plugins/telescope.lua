return {
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
            ["<C-q>"] = function(...)
              require("telescope.actions").send_to_qflist(...)
              return require("trouble").open("quickfix")
            end,
            ["<M-q>"] = function(...)
              require("telescope.actions").send_selected_to_qflist(...)
              return require("trouble").open("quickfix")
            end,
          },
          n = {
            ["<C-b>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
          },
        },
      },
      pickers = {
        buffers = {
          sort_mru = true,
        },
      },
    },
    keys = {
      {
        "<leader> ",
        function()
          return require("telescope.builtin").find_files()
        end,
        desc = "Files",
      },
      {
        "<leader>.",
        function()
          return require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          return require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Grep",
      },
      {
        "<leader>sr",
        function()
          return require("telescope.builtin").resume()
        end,
        desc = "Resume Telescope",
      },
    },
  },
}
