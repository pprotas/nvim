local function use_trouble()
  local status_ok, trouble = pcall(require, "trouble")
  if status_ok then
    if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
      vim.defer_fn(function()
        vim.cmd.lclose()
        trouble.open("loclist")
      end, 0)
    else
      vim.defer_fn(function()
        vim.cmd.cclose()
        trouble.open("quickfix")
      end, 0)
    end
  end
end

use_trouble()
