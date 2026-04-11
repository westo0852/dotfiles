return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	triggers = "auto",
	keys = {
		{
			"<leader>wk",
			function()
				require("which-key").show()
			end,
			desc = "Which-key toggle",
		},
	},
}
