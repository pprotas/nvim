return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    tag = 'v2.8.0',
    keys = {
      {
        "<leader>fe",
        function()
          require("oil").toggle_float()
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer Oil", remap = true },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
}
