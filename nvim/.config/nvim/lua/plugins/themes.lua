return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup({})
		vim.cmd("colorscheme dayfox") -- Light=dayfox Dark=duskfox
	end,
}
