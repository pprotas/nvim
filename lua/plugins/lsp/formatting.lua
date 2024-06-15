return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        gdscript = { "gdformat" },
        clang = { "clang-format" },
        ruby = { "rubocop" },
        sh = { "shfmt" },
        cmake = { "gersemi" },
        rust = { "rustfmt" },
        markdown = { "markdownlint" },
        nix = { "nixpkgs_fmt" }
      },
      format_on_save = {
        lsp_fallback = true,
      },
    },
  },
}
