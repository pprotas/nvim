return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function(_, opts)
      local utils = require("smart-splits.mux.utils")
      if utils.are_we_wezterm() and utils.is_WSL then
        opts.wezterm_cli_path = "wezterm.exe"
      end
      require("smart-splits").setup(opts)
    end,
    keys = {
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        mode = { "n", "t" },
        desc = "Left split",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        mode = { "n", "t" },
        desc = "Bottom split",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        mode = { "n", "t" },
        desc = "Top split",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        mode = { "n", "t" },
        desc = "Right split",
      },

      {
        "<C-Left>",
        function()
          require("smart-splits").resize_left()
        end,
        mode = { "n", "t" },
        desc = "Resize left split",
      },
      {
        "<C-Down>",
        function()
          require("smart-splits").resize_down()
        end,
        mode = { "n", "t" },
        desc = "Resize bottom split",
      },
      {
        "<C-Up>",
        function()
          require("smart-splits").resize_up()
        end,
        mode = { "n", "t" },
        desc = "Resize top split",
      },
      {
        "<C-Right>",
        function()
          require("smart-splits").resize_right()
        end,
        mode = { "n", "t" },
        desc = "Rezize right split",
      },
    },
  },
}
