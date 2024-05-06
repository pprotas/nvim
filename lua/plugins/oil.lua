return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = {
        show_hidden = true,
      },
      -- git = {
      --   add = true,
      --   mv = true,
      --   rm = true,
      -- },
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
  },
}
