local vim = vim
local nvim_lsp = require('lspconfig')

-- Set up completion lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'L', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev, bufopts)
  -- vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
      vim.lsp.buf.format { async = false }
    end
  })
end

local servers = {
  "bashls",
  "dockerls",
  "html",
  "rust_analyzer",
  "tsserver",
  "graphql",
  "sourcekit",
  "yamlls",
  "gopls",
  "sumneko_lua",
  "taplo"
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

-- Ruby
require('lspconfig').solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    solargraph = {
      completion = true,
      definitions = true,
      diagnostics = true,
      formatting = true,
      hover = true,
      references = true,
      rename = true,
    },
  },
})

-- Typescript
--require('lspconfig').tsserver.setup({
--  capabilities = capabilities,
--  cmd = {
--    "typescript-language-server",
--    "--stdio",
--  },
--  filetypes = {
--    "javascript",
--    "javascriptreact",
--    "javascript.jsx",
--    "typescript",
--    "typescriptreact",
--    "typescript.tsx",
--  },
--})

-- Elixir
require 'lspconfig'.elixirls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "elixir-ls" };
}
-- Python
require('lspconfig').pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        pythonPath = "/Users/ajjahn/.pyenv/shims/python"
      },
    },
  },
})


--local black = require "efm/black"
--local isort = require "efm/isort"
local black = {
  formatCommand = "black --fast -",
  formatStdin = true,
}
local isort = {
  formatCommand = "isort --stdout --profile black -",
  formatStdin = true,
}

local shfmt = {
  formatCommand = "shfmt -ci -s -bn -i 2",
  formatStdin = true,
}


--local misspell = {
--  lintCommand = "misspell",
--  lintIgnoreExitCode = true,
--  lintStdin = true,
--  lintFormats = { "%f:%l:%c: %m" },
--  lintSource = "misspell",
--}

--https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
require("lspconfig").efm.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = { documentFormatting = true },
  root_dir = vim.loop.cwd,
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      python = { black },
      bash = { shfmt },
      sh = { shfmt },
    }
  },
  filetypes = { 'python', 'sh', 'bash' }
}



vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,

  -- Enable/Disable virtual text diagnostics
  virtual_text = true,

  signs = true,
  update_in_insert = false,
}
)

vim.fn.sign_define("LspDiagnosticsSignError", { text = "!!" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "⚠" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "*" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "☆" })


-- match the active buffer background color from _colors
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#2E373D guifg=white]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#2E373D]]

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
