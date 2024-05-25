vim.g.mapleader = " "

-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Buffer changes
vim.o.autowrite = true
vim.o.confirm = true
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.virtualedit = "block"

-- Search and replace
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.smartcase = true

-- Tabs and spaces
vim.o.expandtab = true
vim.o.list = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Gutters
vim.o.signcolumn = "yes"

-- Mouse
vim.o.mouse = "a"

-- Buffer/window/split navigation
vim.o.scrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"

-- Spelling
vim.o.spelllang = "en"

-- Colors
vim.o.termguicolors = true
vim.o.cursorline = true

-- Folding
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

-- Wrapping lines
vim.o.wrap = true
vim.o.showbreak = "↪ "
vim.opt.cpoptions:append("n")
vim.o.breakindent = true
vim.o.breakindentopt = "shift:-2"
vim.o.linebreak = true

-- LSP
vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

-- Providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Plugin-specific
-- Better loading performance for "JoosepAlviste/nvim-ts-context-commentstring"
vim.g.skip_ts_context_commentstring_module = true

-- For "folke/which-key.nvim"
vim.o.timeout = true
vim.o.timeoutlen = 300
