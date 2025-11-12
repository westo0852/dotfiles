return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- Load treesitter when opening a buffer
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "vimdoc",
        "go",
        "java",
        "python",
        "lua",
        "markdown",
        "markdown_inline",
        "html",
        "latex",
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- Swapped with tmux prefix key: Ctrl+space <-> Ctrl+A
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection   = "<c-a>",
          node_incremental = "<c-a>",
          node_decremental = "<bs>",
          scope_incremental = false,
        }
      }
    })
  end,
}
