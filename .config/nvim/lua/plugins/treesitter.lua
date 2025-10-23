return {
  "nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- Load treesitter only when opening a buffer
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python",
				"java",
				"lua",
        "markdown"
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					scope_incremental = false,
					node_incremental = "<C-space>",
					node_decremental = "<bs>"
				}
			}
		})
	end,
}
