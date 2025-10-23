vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("syntax on")
vim.o.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Disable comment leader continuation. See :help fo-table
vim.opt.formatoptions:remove { "r", "o" }

-- https://mitchellt.com/2022/05/15/WSL-Neovim-Lua-and-the-Windows-Clipboard.html
if os.getenv("WSL_DISTRO_NAME") ~= nil and vim.fn.executable("win32yank") == 1 then
  vim.g.clipboard = {
    name = "wslClipboard",
    copy = {
      ["+"] = "win32yank -i --crlf",
      ["*"] = "win32yank -i --crlf",
    },
    paste = {
      ["+"] = "win32yank -o --lf",
      ["*"] = "win32yank -o --lf",
    },
    cache_enabled = true 
  }
end
vim.opt.clipboard = "unnamedplus"
