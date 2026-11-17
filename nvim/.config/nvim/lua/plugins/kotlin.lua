return {
	{
		"AlexandrosAlexiou/kotlin.nvim",
		ft = {
			"kotlin",
		},
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"oil.nvim",
			"trouble.nvim",
		},
		opts = {},
		config = function()
			require("kotlin").setup({
				root_markers = { "settings.gradle.kts", "gradlew", ".git" },
				jvm_args = { "-Xmx8g" },
				inlay_hints = {
					enabled = true,
					parameters_compiled = false,
					call_chains = true,
				},
				reload_workspace = { on_build_file_save = "always" },
				dap = { console = "internalConsole" },
			})
		end,
	},
	{ "folke/trouble.nvim" },
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
		lazy = false,
	},
}
