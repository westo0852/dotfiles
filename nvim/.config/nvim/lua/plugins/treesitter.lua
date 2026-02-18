return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- Load treesitter when opening a buffer
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"vimdoc",
				"lua",
				"go",
				"java",
				"c",
				"cpp",
				"rust",
				"javascript",
				"python",
				"markdown",
				"markdown_inline",
				"html",
				"latex",
				"json",
			},
			highlight = { enable = true },
			indent = { enable = true },
			-- TODO Enable with treesitter-modules
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = "<c-a>",
			-- 		node_incremental = "<c-a>",
			-- 		node_decremental = "<bs>",
			-- 		scope_incremental = false,
			-- 	},
			-- },
		})
	end,
}
