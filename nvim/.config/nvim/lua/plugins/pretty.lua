return {
	-- Icons
	{ "nvim-tree/nvim-web-devicons", opts = {}},
  { "echasnovski/mini.nvim", version = false },

	-- Keybindings popup
	{
    "folke/which-key.nvim",
  	event = "VeryLazy",
  	init = function()
      vim.o.timeout = true
    	vim.o.timeoutlen = 500
  	end,
  	triggers = "auto",
  	keys = {
      {
        "<leader>?",
      	function()
          require("which-key").show({ global = false })
      	end,
      	desc = "Buffer Local Keymaps (which-key)",
    	},
  	},
	},
}
