local vim = vim

--------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------

-- vim.cmd[[let g:onedark_style = 'warmer']]
-- vim.cmd[[colorscheme onedark]]


vim.o.foldenable = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.synmaxcol = 128
vim.o.wrap = false

vim.o.colorcolumn = '+1'
vim.o.textwidth = 80
vim.o.winwidth = 81

-- Uncomment below if terminal is slow.
-- vim.o.showcmd = false
-- vim.o.ruler = false

--------------------------------------------------------------------------------
-- BUFFER HANDLING
--------------------------------------------------------------------------------
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autowriteall = true
vim.o.hidden = true

--------------------------------------------------------------------------------
-- SPLITS & NAVIGATION
--------------------------------------------------------------------------------
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.diffopt = vim.o.diffopt .. ',vertical'

--------------------------------------------------------------------------------
-- TABS & SPACES
--------------------------------------------------------------------------------
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.shiftround = true


--------------------------------------------------------------------------------
-- EDITING
--------------------------------------------------------------------------------

local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set('i', 'jj', '<ESC>', bufopts)

-- live substitution
vim.o.inccommand = "split"
