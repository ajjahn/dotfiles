local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'
  use 'christoomey/vim-tmux-navigator'
  use 'rizzatti/dash.vim'

  use 'vim-scripts/EnhCommentify.vim'

  -- Ruby block awareness: ar/ir
  use 'kana/vim-textobj-user'
  use 'nelstrom/vim-textobj-rubyblock'
  -- Ruby block syntax toggling
  use 'jgdavey/vim-blockle'

  use 'preservim/nerdtree'
  use 'leafgarland/typescript-vim'

  use 'skywind3000/asyncrun.vim'
  use 'tpope/vim-rails'
  use 'tpope/vim-dispatch'
  use 'vim-test/vim-test'

  -- TODO: Decide if I want to use the following plugins
  use 'moll/vim-bbye'
  use 'tommcdo/vim-exchange'
  -- use 'easymotion/vim-easymotion'
  -- use 'andymass/vim-matchup'
  -- use 'tpope/vim-rails'
  -- use 'tpope/vim-dispatch'
  --
  use 'dhruvasagar/vim-table-mode'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
