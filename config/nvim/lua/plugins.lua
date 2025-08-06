local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
end

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  use "RRethy/vim-illuminate" -- repeated word highlighting
  use "christoomey/vim-tmux-navigator"
  use "dhruvasagar/vim-table-mode"
  use "jgdavey/vim-blockle" -- Ruby block syntax toggling
  use "kana/vim-textobj-user" -- Ruby block awareness: ar/ir
  use "leafgarland/typescript-vim"
  use "moll/vim-bbye"
  use "nelstrom/vim-textobj-rubyblock" -- Ruby block awareness: ar/ir
  use "preservim/nerdtree"
  use "skywind3000/asyncrun.vim"
  use "tommcdo/vim-exchange"
  use "tpope/vim-endwise"
  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"
  use "vim-scripts/EnhCommentify.vim"


  use {
    'nvim-tree/nvim-tree.lua',
    config = function() require("_tree") end
  }


  -- autopairs
  use {
    "windwp/nvim-autopairs",
    config = function() require("_autopairs") end
  }
  -- completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "kyazdani42/nvim-web-devicons" },
      { "onsails/lspkind.nvim" },
      { "andersevenrud/cmp-tmux" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
    config = function() require("_completion") end
  }

  use {
    "petertriho/cmp-git",
    requires = "nvim-lua/plenary.nvim"
  }

  -- lsp
  use { "neovim/nvim-lspconfig",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "nvim-lua/lsp_extensions.nvim" },
    },
    config = function() require("_lsp") end
  }

  -- trouble diagnostics
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("_trouble") end
  }

  -- git signs in the gutter
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function() require("gitsigns").setup() end
  }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function() require("_telescope") end
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { { "tami5/sql.nvim" } },
    config = function()
      require("telescope").load_extension("frecency")
    end
  }
  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    config = function()
      require("telescope").load_extension("fzy_native")
    end
  }
  use {
    "nvim-telescope/telescope-github.nvim",
    config = function()
      require("telescope").load_extension("gh")
    end
  }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end
  }

  -- github
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("_github")
    end
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function() require("_treesitter") end
  }

  -- colorschemes
  use {
    'sainnhe/everforest',
    config = function() require("_colors") end
  }

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


  if packer_bootstrap then
    require("packer").sync()
  end
end)
