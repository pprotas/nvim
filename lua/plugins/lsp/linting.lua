return {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local linters_by_ft = {
        gdscript = { "gdlint" },
        c = { "cppcheck" },
        ruby = { "ruby", "rubocop" },
        sh = { "shellcheck" },
        cmake = { "cmakelint" },
        markdown = { "markdownlint" },
        javascript = {},
        typescript = {},
      }

      local lint = require("lint")

      lint.linters_by_ft = linters_by_ft

      -- Configure individual linters here
      local cppcheck = lint.linters.cppcheck
      cppcheck.args = vim.tbl_extend("force", cppcheck.args, { "--suppress=missingIncludeSystem" })

      -- Dynamically lint during coding
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
