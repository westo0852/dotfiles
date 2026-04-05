return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local langs = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"java",
			"javascript",
			"json",
			"latex",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"sql",
			"typescript",
			"typst",
			"vimdoc",
			"xml",
			"yaml",
		}
		require("nvim-treesitter").install(langs)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = langs,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
