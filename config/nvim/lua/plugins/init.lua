local vim = vim

return {
  { "RRethy/vim-illuminate" }, -- repeated word highlighting
  { "tommcdo/vim-exchange" },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },
  {
    "klen/nvim-config-local",
    opts = {
      config_files = {
        ".nvim.lua",
      },
      lookup_parents = true,
    }
  },

  {
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    -- init = function() require("_autopairs") end
  },
  {
    'altermo/ultimate-autopair.nvim',
    enabled = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {},
  },

  -- git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        layout = {
          position = "right", -- | top | left | right | horizontal | vertical
          ratio = 0.4
        },
      },
    },
  },
}


-- Graveyard??
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

-- use "easymotion/vim-easymotion"
-- use "andymass/vim-matchup"
-- use "tpope/vim-dispatch"
-- use "tpope/vim-rails"
-- use "vim-test/vim-test"
-- use "rizzatti/dash.vim"
-- use 'flazz/vim-colorschemes'
-- use 'sheerun/vim-polyglot'
-- use 'navarasu/onedark.nvim'
-- { "jgdavey/vim-blockle" },   -- Ruby block syntax toggling
-- { "kana/vim-textobj-user" }, -- Ruby block awareness: ar/ir
-- { "nelstrom/vim-textobj-rubyblock" }, -- Ruby block awareness: ar/ir
-- { "tpope/vim-endwise" },
