return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {
    model = "gpt-4.1",
    temperature = 0.0,
    window = {
      layout = "vertical",
      width = 0.4,
      title = "CopilotChat",
      zindex = 100,
    },
  }
}
