require('packer').use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  }
}

require('gitsigns').setup()
