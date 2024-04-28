return {
  {
    "aserowy/tmux.nvim",
    opts = {
      navigation = {
        enable_default_keybindings = false,
        persist_zoom = true,
      },
      resize = {
        enable_default_keybindings = false,
      },
      copy_sync = {
        enable = false,
      },
    },
    keys = {
      {
        "<C-h>",
        function()
          require("tmux").move_left()
        end,
        mode = { "n", "t" },
        desc = "Tmux Move Left",
      },
      {
        "<C-j>",
        function()
          require("tmux").move_bottom()
        end,
        mode = { "n", "t" },
        desc = "Tmux Move Bottom",
      },
      {
        "<C-k>",
        function()
          require("tmux").move_top()
        end,
        mode = { "n", "t" },
        desc = "Tmux Move Top",
      },
      {
        "<C-l>",
        function()
          require("tmux").move_right()
        end,
        mode = { "n", "t" },
        desc = "Tmux Move Right",
      },

      {
        "<C-Left>",
        function()
          require("tmux").resize_left()
        end,
        mode = { "n", "t" },
        desc = "Tmux Resize Left",
      },
      {
        "<C-Down>",
        function()
          require("tmux").resize_bottom()
        end,
        mode = { "n", "t" },
        desc = "Tmux Resize Bottom",
      },
      {
        "<C-Up>",
        function()
          require("tmux").resize_top()
        end,
        mode = { "n", "t" },
        desc = "Tmux Resize Top",
      },
      {
        "<C-Right>",
        function()
          require("tmux").resize_right()
        end,
        mode = { "n", "t" },
        desc = "Tmux Resize Right",
      },
    },
  },
}
