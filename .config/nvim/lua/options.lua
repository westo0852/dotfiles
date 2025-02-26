vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("syntax on")
vim.o.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Disable comment leader continuation. See :help fo-table
vim.opt.formatoptions:remove { "r", "o" }

vim.opt.clipboard = "unnamedplus"
