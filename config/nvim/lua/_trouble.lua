require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
vim.keymap.set("n", "gh", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { silent = true, noremap = true }
)
