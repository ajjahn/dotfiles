local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'
  use 'christoomey/vim-tmux-navigator'
  use 'rizzatti/dash.vim'





  -- TODO: Decide if I want to use the following plugins
  use 'tommcdo/vim-exchange'
  -- use 'easymotion/vim-easymotion'
  -- use 'andymass/vim-matchup'
  -- use 'tpope/vim-rails'
  -- use 'tpope/vim-dispatch'

end)
