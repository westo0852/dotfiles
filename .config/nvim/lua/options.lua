vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("syntax on")
vim.o.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Disable comment leader continuation. See :help fo-table
vim.opt.formatoptions:remove { "r", "o" }

vim.opt.clipboard = "unnamedplus"
