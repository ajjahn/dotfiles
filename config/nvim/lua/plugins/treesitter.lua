return {
  'neovim-treesitter/nvim-treesitter',
  lazy = false,
  dependencies = {
    'neovim-treesitter/treesitter-parser-registry',
    "brianhuster/treesitter-endwise.nvim",
  },
  build = {
    ':TSUpdate',
    function()
      local ensureInstalled = {
          "bash",
          "embedded_template",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
      }
      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require('nvim-treesitter').install(parsersToInstall)
    end,
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      -- pattern = { '' }, -- all filetypes
      callback = function() 
        pcall(vim.treesitter.start) -- highlighting
      end,
    })
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
}
