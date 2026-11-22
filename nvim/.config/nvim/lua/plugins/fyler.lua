return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false, -- Necessary for `default_explorer` to work properly
	opts = {
		integrations = {
			icon = "mini_icons",
		},
		ui = {
			hidden_items = {
				always_visible = { "dotfiles" },
			},
			indent_guides = true,
		},
		views = {
			finder = {
				close_on_select = false,
			},
		},
	},
}
