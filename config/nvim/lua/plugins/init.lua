local vim = vim

return {
  { "RRethy/vim-illuminate" }, -- repeated word highlighting
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
-- { "jgdavey/vim-blockle" },   -- Ruby block syntax toggling
-- { "kana/vim-textobj-user" }, -- Ruby block awareness: ar/ir
-- { "nelstrom/vim-textobj-rubyblock" }, -- Ruby block awareness: ar/ir
