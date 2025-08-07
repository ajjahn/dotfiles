return {
  "dhruvasagar/vim-table-mode",
  cmd = {
    "TableModeToggle",
    "Tableize",
  },
  keys = {
    { "<leader>tm", "<cmd>TableModeToggle<cr>" },
    { "<leader>t",  "<cmd>Tableize<cr>",       mode = "v" },
  },
  init = function()
    local group = vim.api.nvim_create_augroup("table-mode-corner-md", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      group = group,
      command = "let b:table_mode_corner='|'",
    })
  end,
}
