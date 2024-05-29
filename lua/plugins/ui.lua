return {
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      render = "virtual",
      enable_tailwind = true,
    },
  },
  {
    "goolord/alpha-nvim",
    dependencies = "nvim-lualine/lualine.nvim",
    priority = 1000,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#DA4939" })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#FF875F" })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#FFC66D" })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#00FF03" })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#00AFFF" })
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#8800FF" })

      dashboard.section.header.type = "group"
      dashboard.section.header.val = {
        -- stylua: ignore start
        { type = "text", val = "i use ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗      ", opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" }, },
              { type = "text", val = "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║", opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" }, },
              { type = "text", val = "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║", opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" }, },
              { type = "text", val = "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║", opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" }, },
              { type = "text", val = "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║", opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" }, },
          { type = "text", val = "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ btw", opts = { hl = "NeovimDashboardLogo6", shrink_margin = false, position = "center" }, },
        -- stylua: ignore end
      }
      dashboard.section.buttons.val = {
        dashboard.button("x", "  Restore session", "<cmd>lua require('persistence').load()<cr>"),
        dashboard.button("e", "  New file", "<cmd>enew<bar>startinsert<cr>"),
        dashboard.button("c", "  Config", ":cd $XDG_CONFIG_HOME/nvim | :lua require('persistence').load()<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }

      alpha.setup(dashboard.config)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    keys = {
      {
        "<leader>nn",
        function()
          local telescope = require("telescope")

          telescope.load_extension("notify")
          telescope.extensions.notify.notify()
        end,
        desc = "Notify history",
      },
    },
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },

              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    keys = {
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Last message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("telescope")
        end,
        desc = "Noice history",
      },
      {
        "<leader>na",
        function()
          require("noice").cmd("all")
        end,
        desc = "All",
      },
      {
        "<leader>nd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss",
      },
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      highlights = {
        ["@text.emphasis.markdown_inline"] = { style = "italic" },
        ["@text.strong.markdown_inline"] = { style = "bold" },
      },
      styles = {
        types = "NONE",
        methods = "NONE",
        numbers = "NONE",
        strings = "NONE",
        comments = "italic",
        keywords = "bold,italic",
        constants = "bold",
        functions = "bold",
        operators = "NONE",
        variables = "NONE",
        parameters = "italic",
        conditionals = "italic",
        virtual_text = "italic",
      },
      options = {
        cursorline = true,
        highlight_inactive_windows = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("onedark_dark")
    end,
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    version = false,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      local indentscope = require("mini.indentscope")
      opts.draw = {
        animation = indentscope.gen_animation.none(),
      }
      indentscope.setup(opts)
    end,
    init = function()
      -- Disable indentscope for some files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "noice",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function()
        return { "treesitter" }
      end,
    },
    init = function()
      -- Folding
      -- TODO: This isn't fully working?
      vim.opt.fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",
      }
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        alacritty = { enabled = true },
      },
    },
    keys = {
      {
        "<Leader>z",
        "<cmd>ZenMode<cr>",
        desc = "Zen mode",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SmiteshP/nvim-navic",
    },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { "alpha", "spectre_panel", "trouble", "lazygit", "oil" },
        section_separators = "",
        component_separators = "",
      },
      winbar = {
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
          {
            "navic",
            color_correction = "static",
          },
        },
      },
      inactive_winbar = {
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_c = {
          "diagnostics",
        },
        lualine_x = {
          {
            function()
              local reg = vim.fn.reg_recording()
              return reg ~= "" and "recording @" .. reg or ""
            end,
            color = { fg = "orange", gui = "bold" },
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "lazy" },
    },
  },
}
