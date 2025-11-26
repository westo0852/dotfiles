-- Options
vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("syntax on")
vim.o.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Disable comment leader continuation. See :help fo-table
vim.opt.formatoptions:remove { "r", "o" }

-- Keymaps
vim.keymap.set("n", "<ESC>", ":noh<CR>", { desc = "Clear search highlighting", silent = true })

-- Autotoggle relative line numbers based on context
-- https://www.reddit.com/r/neovim/comments/y0c9vk/comment/irrgfin/
local numbertogglegroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = true
  end,
  group = numbertogglegroup,
})

autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = false
  end,
  group = numbertogglegroup,
})

local wsl = vim.fn.has("wsl") == 1

-- Use win32yank to sync Windows/WSL clipboards
if wsl and vim.fn.executable("win32yank") == 1 then
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

-- Open URLs with wsl-open
if wsl then
  vim.keymap.set("n", "gx", function()
    local url = vim.fn.expand("<cfile>")
    vim.fn.system({ "wsl-open", url })
  end, { desc = "Open URL under cursor" })
end
