vim.keymap.set("n", "<leader>co", function()
  require("util.obsidian").open()
end, { desc = "Open in Obsidian", noremap = true, silent = true })
