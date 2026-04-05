-- Package manager
require("config.lazy")

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("syntax on")
vim.o.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Disable comment leader continuation. See :help fo-table
vim.opt.formatoptions:remove({ "r", "o" })

vim.keymap.set("n", "<ESC>", ":noh<CR>", { desc = "Clear search highlighting", silent = true })

-- Disable completion for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		require("cmp").setup.buffer({
			enabled = false,
		})
	end,
})

-- Autotoggle relative line numbers based on context
local numbertogglegroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = "*",
	callback = function()
		vim.wo.relativenumber = true
	end,
	group = numbertogglegroup,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	pattern = "*",
	callback = function()
		vim.wo.relativenumber = false
	end,
	group = numbertogglegroup,
})

-- Use win32yank to sync Windows/WSL clipboards
local wsl = vim.fn.has("wsl") == 1

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
		cache_enabled = true,
	}
end

-- Open URLs with wsl-open
if wsl then
	vim.keymap.set("n", "gx", function()
		local url = vim.fn.expand("<cfile>")
		vim.fn.system({ "wsl-open", url })
	end, { desc = "Open URL under cursor" })
end
