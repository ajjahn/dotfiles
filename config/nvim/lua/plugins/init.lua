return {
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
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
    },
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
