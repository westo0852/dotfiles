return {
  "rebelot/kanagawa.nvim",
	-- Load during startup and before other plugins
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({})
	  vim.cmd("colorscheme kanagawa-wave") -- "wave", "dragon", "lotus"
	end
}
