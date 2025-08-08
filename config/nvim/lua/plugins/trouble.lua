return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = {
    "Trouble",
  },
  keys = {
    { "gh", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>"},
  },
  opts = {},
}
