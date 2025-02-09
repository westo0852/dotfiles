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
