local vim = vim
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "onsails/lspkind.nvim" },
      -- { "andersevenrud/cmp-tmux" },
      { "hrsh7th/cmp-buffer" },
      -- { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "windwp/nvim-autopairs" },
      { "zbirenbaum/copilot-cmp" },
    },
    opts = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end
      local cmp = require("cmp")

      return {
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        formatting = {
          format = function(entry, vim_item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return require('lspkind').cmp_format({
              mode = "symbol_text",
              symbol_map = { Copilot = "" },
            })(entry, vim_item)
          end
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),

          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },

        sources = cmp.config.sources({
          { name = "copilot" },
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      }
    end,
    init = function()
      local cmp = require('cmp')

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- insert parens for completed functions
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      -- Colorize completion types
      -- gray
      vim.cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
      -- blue
      vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
      vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch]]
      -- light blue
      vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
      vim.cmd [[highlight! link CmpItemKindInterface CmpItemKindVariable]]
      vim.cmd [[highlight! link CmpItemKindText CmpItemKindVariable]]
      -- pink
      vim.cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
      vim.cmd [[highlight! link CmpItemKindMethod CmpItemKindFunction]]
      -- front
      vim.cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
      vim.cmd [[highlight! link CmpItemKindProperty CmpItemKindKeyword]]
      vim.cmd [[highlight! link CmpItemKindUnit CmpItemKindKeyword]]
    end
  },
  { -- not sure yet
    "petertriho/cmp-git",
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
      -- options go here
    },
    init = function()
      table.insert(require("cmp").get_config().sources, { name = "git" })
    end
  }
}
