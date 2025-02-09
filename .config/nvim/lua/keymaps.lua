vim.keymap.set("n", "<ESC>", ":noh<CR>", { desc = "Clear search highlighting", silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ts", builtin.grep_string, { desc = "Telescope find strings" })

vim.keymap.set("n", "<leader>wk", function()
	require("which-key").show()
end, { desc = "Which-key toggle" })
