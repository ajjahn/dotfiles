return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>",  "<cmd>TmuxNavigateLeft<cr>",     mode = { "v", "n" } },
      { "<c-j>",  "<cmd>TmuxNavigateDown<cr>",     mode = { "v", "n" } },
      { "<c-k>",  "<cmd>TmuxNavigateUp<cr>",       mode = { "v", "n" } },
      { "<c-l>",  "<cmd>TmuxNavigateRight<cr>",    mode = { "v", "n" } },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "v", "n" } },
    },
  },

  {
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
  },

  { "RRethy/vim-illuminate" }, -- repeated word highlighting

  -- { "jgdavey/vim-blockle" },   -- Ruby block syntax toggling
  -- { "kana/vim-textobj-user" }, -- Ruby block awareness: ar/ir
  -- { "nelstrom/vim-textobj-rubyblock" }, -- Ruby block awareness: ar/ir
  { "tommcdo/vim-exchange" },
  { "tpope/vim-endwise" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "\\x", mode = { "v", "n" } },
    },
    opts = {
      toggler = { line = "\\x", },
      opleader = { line = "\\x", },
    },
  },

  {
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "NvimTreeToggle",
    },
    keys = {
      { "-", "<cmd>NvimTreeToggle<cr>" },
    },
    opts = {
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<ESC>', api.tree.close, opts('Close'))
        vim.keymap.set('n', '-', api.tree.toggle, opts('Toggle'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end,
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = {
            width = 40,
            height = 60,
            row = 0,
            col = 0,
          },
        },
      }
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  {
    "windwp/nvim-autopairs",
    init = function() require("_autopairs") end
  },


  -- colorscheme
  {
    'sainnhe/everforest',
    init = function() require("_colors") end
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_install = require("nvim-treesitter.install")
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function() require("_treesitter") end
  },
  -- ts_install.prefer_git = true
  -- build = ":TSUpdate",
  -- local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   run = function()
  --     local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
  --     ts_update()
  --   end,
  --   config = function() require("_treesitter") end
  -- }

  -- completion
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
      -- { "zbirenbaum/copilot-cmp" },
    },
    config = function() require("_completion") end
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
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function() require("_telescope") end
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*", -- install the latest stable version
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("telescope").load_extension("fzy_native")
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {
      { "nvim-telescope/telescope.nvim" }
    },
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    -- config = function()
    -- require("telescope").load_extension("fzf_native")
    -- end
  },
  { -- Replace by octo?
    "nvim-telescope/telescope-github.nvim",
    config = function()
      require("telescope").load_extension("gh")
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "nvim-lua/lsp_extensions.nvim" },
    },
    config = function() require("_lsp") end
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function() require("_trouble") end
  },

  -- git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },

  -- github
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("_github")
    end
  }
}




-- copilot
-- use {
--   "zbirenbaum/copilot.lua",
--   cmd = "Copilot",
--   config = function()
--     require("copilot").setup({
--       panel = {
--         enabled = true,
--         auto_refresh = true,
--         layout = {
--           position = "right",   -- | top | left | right | horizontal | vertical
--           ratio = 0.4
--         },
--       },
--     })
--   end
-- }
-- use {
--   "zbirenbaum/copilot-cmp",
--   config = function()
--     require("copilot_cmp").setup()
--   end
-- }




-- use {
--   "catppuccin/nvim",
--   as = "catppuccin",
--   config = function() require("_colors") end
-- }

-- quick jump
-- use {
--   "ggandor/leap.nvim",
--   requires = {
--     { "tpope/vim-repeat" },
--   },
--   config = function()
--     require("leap").add_default_mappings()
--   end,
-- }

-- use {
--   'Exafunction/codeium.vim',
--   config = function() require("_codeium") end
-- }

-- Graveyard??
-- use "easymotion/vim-easymotion"
-- use "andymass/vim-matchup"
-- use "tpope/vim-dispatch"
-- use "tpope/vim-rails"
-- use "vim-test/vim-test"
-- use "rizzatti/dash.vim"
-- use 'flazz/vim-colorschemes'
-- use 'sheerun/vim-polyglot'
-- use 'navarasu/onedark.nvim'
