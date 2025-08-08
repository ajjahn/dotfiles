return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "brianhuster/treesitter-endwise.nvim",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "bash",
          "embedded_template",
          "html",
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
        },
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
        endwise = {
          enable = true
        },
      })
    end
  },
}
