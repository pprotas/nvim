return {
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    lazy = true,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    build = "make",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    version = false,
    opts = {
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = false
          }
        },
        mappings = {
          i = {
            ["<C-b>"] = "delete_buffer",
            ["<C-i>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              return require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
            end,
            ["<C-h>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              return require("telescope.builtin").find_files({ hidden = true, default_text = line })
            end,
          },
        },
      },
      pickers = {
        buffers = {
          sort_mru = true,
        },
      },
      extensions = {
        live_grep_args = {
          mappings = {
            i = {
              ["<C-k>"] = function(...)
                return require("telescope-live-grep-args.actions").quote_prompt()(...)
              end,
            },
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      telescope.load_extension("live_grep_args")
      telescope.load_extension("fzf")
    end,
    keys = {
      {
        "<leader> ",
        function()
          return require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<leader>.",
        function()
          return require("telescope.builtin").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>/",
        function()
          return require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Find text (ripgrep)",
      },
      {
        "<leader>sh",
        function()
          return require("telescope.builtin").oldfiles()
        end,
        desc = "File history",
      },
      {
        "<leader>sr",
        function()
          return require("telescope.builtin").resume()
        end,
        desc = "Resume previous search",
      },
    },
  },
}
