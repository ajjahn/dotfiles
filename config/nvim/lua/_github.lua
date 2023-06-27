local vim = vim
local octo = require("octo")

octo.setup()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
map('n', '<leader>pr', "<CMD>Octo pr list<cr>", opts)

-- autocomplete for octo file type
-- vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
-- vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })

vim.treesitter.language.register('markdown', 'octo')
