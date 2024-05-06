return {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        gdscript = { "gdlint" },
        c = { "cppcheck" },
        ruby = { "ruby", "rubocop" },
        sh = { "shellcheck" },
        cmake = { "cmakelint" },
        javascript = {},
        typescript = {},
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      for ft, _ in pairs(opts.linters_by_ft) do
        table.insert(opts.linters_by_ft[ft], 1, "codespell")
      end

      lint.linters_by_ft = opts.linters_by_ft

      -- Configure individual linters here
      local cppcheck = lint.linters.cppcheck
      cppcheck.args = vim.tbl_extend("force", cppcheck.args, { "--suppress=missingIncludeSystem" })
    end,
  },
}
