local vim = vim


vim.keymap.set(
      'i', '<C-g>', function() vim.fn['codeium#Accept']() end,
      { silent = true, noremap = true })
