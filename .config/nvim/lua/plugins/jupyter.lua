return {
  "untitled-ai/jupyter_ascending.vim",
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>jx", "<Plug>JupyterExecute", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>jX", "<Plug>JupyterExecuteAll", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>jr", "<Plug>JupyterRestart", { noremap = true, silent = true })
  end,
}
