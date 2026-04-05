return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false, -- Necessary for `default_explorer` to work properly
	opts = {
		views = {
			finder = {
				close_on_select = false,
			},
		},
	},
}
