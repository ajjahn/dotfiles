local vim = vim

return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "Octo"
  },
  keys = {
    { "<leader>pr", "<CMD>Octo pr list<CR>" }
  },
  opts = {},
  init = function()
    vim.treesitter.language.register('markdown', 'octo')
  end,
}
