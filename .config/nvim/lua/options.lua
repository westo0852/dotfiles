-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Disable comment leader continuation; see :help fo-table
vim.opt.formatoptions:remove { "r", "o" }

vim.opt.clipboard = "unnamedplus"
