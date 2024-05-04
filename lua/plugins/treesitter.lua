return {
  { "nvim-treesitter/nvim-treesitter-context", lazy = true },
  { "RRethy/nvim-treesitter-endwise", lazy = true },
  { "windwp/nvim-ts-autotag", lazy = true },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "ckolkey/ts-node-action",
    keys = {
      {
        "M",
        function()
          require("ts-node-action").node_action()
        end,
        "Trigger Node Action",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      "RRethy/vim-illuminate",
    },
    event = "VeryLazy",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    version = false,
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB

            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        incremental_selection = {
          keymaps = {
            init_selection = "+",
            node_incremental = "+",
            node_decremental = "-",
          },
        },
        endwise = {
          enable = true,
        },
        autotag = {
          enable = true,
          enable_close_on_slash = false,
        },
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "latex",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "ruby",
          "graphql",
          "vimdoc",
        },
      })
    end,
  },
}
