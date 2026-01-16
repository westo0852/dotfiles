return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- No need for require("nvim-treesitter").setup() if using default settings
		require("nvim-treesitter").install({
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
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
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
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
