return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    tag = 'v2.8.0',
    keys = {
      {
        "<leader>e",
        function()
          require("oil").toggle_float()
        end,
        desc = "Oil",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
}
