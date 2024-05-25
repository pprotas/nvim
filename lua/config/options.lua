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
vim.o.cursorline = true

-- Mouse
vim.o.mouse = "a"

-- Buffer/window/split navigation
vim.o.scrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"

-- Spelling
vim.o.spelllang = "en"

-- Wrapping lines
vim.o.wrap = true
vim.o.showbreak = "↪ "
vim.opt.cpoptions:append("n")
vim.o.breakindent = true
vim.o.breakindentopt = "shift:-2"
vim.o.linebreak = true

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
