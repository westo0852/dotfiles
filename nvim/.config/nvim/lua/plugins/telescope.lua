return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	keys = {
		{
			"<leader>tf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope find files",
		},
		{
			"<leader>ts",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Telescope find strings",
		},
	},

	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					horizontal = {
						preview_cutoff = 0,
					},
				},
				path_display = "shorten",
			},
			-- pickers = {
			-- 	find_files = {
			-- 		hidden = true,
			-- 	},
			-- 	grep_string = {
			-- 		hidden = true,
			-- 	},
			-- },
		})
	end,
}
