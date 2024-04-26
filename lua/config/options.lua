vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.autowrite = true -- Enable auto write

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true            -- Confirm to save changes before exiting modified buffer
opt.cursorline = true         -- Enable highlighting of the current line
opt.expandtab = true          -- Use spaces instead of tabs
opt.ignorecase = true         -- Ignore case
opt.inccommand = "nosplit"    -- preview incremental substitute
opt.list = true               -- Show some invisible characters (tabs...
opt.mouse = "a"               -- Enable mouse mode
opt.number = true             -- Print line number
opt.pumblend = 10             -- Popup blend
opt.pumheight = 10            -- Maximum number of entries in a popup
opt.relativenumber = true     -- Relative line numbers
opt.scrolloff = 8             -- Lines of context
opt.shiftwidth = 2            -- Size of an indent
opt.signcolumn = "yes"        -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true          -- Don't ignore case with capitals
opt.smartindent = true        -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true         -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true         -- Put new windows right of current
opt.tabstop = 2               -- Number of spaces tabs count for
opt.termguicolors = true      -- True color support
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.cmdheight = 0

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.diagnostic.config({
  update_in_insert = false,
})

vim.o.wrap = true
vim.o.showbreak = "↪ "
vim.opt.cpoptions:append("n")
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:-2"
vim.opt.linebreak = true
