local config = function()
  local vim = vim
  local nvim_lsp = require('lspconfig')

  -- Set up completion lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()


  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- https://github.com/redhat-developer/yaml-language-server/issues/486#issuecomment-1046792026
    -- if client.name == "yamlls" then
    --   client.server_capabilities.documentFormattingProvider = true
    -- end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'L', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
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
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = buffer,
    --   callback = function()
    --     if client.server_capabilities.documentFormattingProvider then
    --       vim.lsp.buf.format { async = false }
    --     end
    --   end
    -- })
  end

  local servers = {
    "bashls",
    "dockerls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "sourcekit",
    "taplo",
    "ts_ls",
    -- "yamlls",
    "marksman",
    -- "graphql",
  }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
  end

  require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    settings = {
      ['rust-analyzer'] = {
        check = {
          -- allFeatures = true,
          disabled = { "unresolved-proc-macro" },
          overrideCommand = {
            'cargo', 'clippy', '--workspace', '--message-format=json', '--all-targets', '--all-features'
          }
        }
      }
    }
  }

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

  -- Elixir
  require 'lspconfig'.elixirls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "elixir-ls" },
  }
  -- Python
  local home = os.getenv("HOME")
  local util = require('lspconfig').util
  require('lspconfig').pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "pyright-langserver", "--stdio", "--verbose" },
    -- rootMarkers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },

    -- root_dir = vim.fs.dirname(vim.fs.find('.git', { path = root_dir, upward = true })[1]),

    root_dir = util.root_pattern(".git/", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile",
      "pyrightconfig.json"),
    settings = {
      -- rootMarkers = { ".git/" },
      -- rootMarkers = { ".git/", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", },
      python = {
        analysis = {
          pythonPath = home .. "/.local/share/mise/shims/python"
        },
      },
    },
  })


  require('lspconfig').ruff.setup({
    init_options = { documentFormatting = true },
    capabilities = capabilities,
    on_attach = on_attach,
  })


  local shfmt = {
    formatCommand = "shfmt -ci -s -bn -i 2",
    formatStdin = true,
  }


  --https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
  require("lspconfig").efm.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    root_dir = vim.loop.cwd,
    settings = {
      rootMarkers = { ".git/" },
      languages = {
        zsh = { shfmt },
        bash = { shfmt },
        sh = { shfmt },
      }
    },
    filetypes = { 'zsh', 'sh', 'bash' }
  }

  require("lspconfig").jdtls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "/opt/homebrew/bin/jdtls", "--java-executable", "/opt/homebrew/opt/openjdk/bin/java", },
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
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "nvim-lua/lsp_extensions.nvim" },
    },
    config = config
  }
}
