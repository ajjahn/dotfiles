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
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  dependencies = {
    "brianhuster/treesitter-endwise.nvim",
  },
  build = ':TSUpdate',
  init = function()
    require('nvim-treesitter').install(ensureInstalled)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '' },
      callback = function() pcall(vim.treesitter.start) end,
    })
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
}
