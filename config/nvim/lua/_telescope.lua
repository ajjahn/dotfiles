local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    -- file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    -- generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,

    -- Esc exits instead of normal mode
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    fzf = {
      fuzzy = false,                  -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
}
require("telescope").load_extension "file_browser"

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require 'telescope.builtin'.git_files, opts)
  if not ok then require 'telescope.builtin'.find_files(opts) end
end

M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map)
      map('i', '<c-d>', actions.git_delete_branch)
      map('n', '<c-d>', actions.git_delete_branch)
      return true
    end
  })
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- map('n', '<space>', "<CMD>lua require('telescope.builtin').resume()<CR>", opts)

map('n', '<space>jl', "<CMD>lua require('telescope.builtin').jumplist()<CR>", opts)
map('n', '<space>qf', "<CMD>lua require('telescope.builtin').quickfix()<CR>", opts)
map('n', '<space>reg', "<CMD>lua require('telescope.builtin').registers()<CR>", opts)

map('n', '<c-p>', "<CMD>lua require('_telescope').project_files()<CR>", opts)
map('n', 'K', "<CMD>lua require('telescope.builtin').grep_string()<CR>", opts)
map('n', '<c-g>', "<CMD>lua require('telescope.builtin').live_grep()<CR>", opts)

map('n', '<leader>buf', "<CMD>lua require('telescope.builtin').buffers()<CR>n", opts)


-- LSP Pickers
map('n', '<leader>gr', "<CMD>lua require('telescope.builtin').lsp_references()<CR>", opts)


-- Git Pickers
map('n', '<leader>gb', "<CMD>lua require('_telescope').git_branches()<CR>", opts)
map('n', '<leader>gs', "<CMD>lua require('telescope.builtin').git_status()<CR>", opts)
map('n', '<leader>gc', "<CMD>lua require('telescope.builtin').git_commits()<CR>", opts)
map('n', '<leader>gl', "<CMD>lua require('telescope.builtin').git_bcommits()<CR>", opts)
map('n', '<leader>gw', "<CMD>lua require('telescope.builtin').git_stash()<CR>", opts)

-- GitHub
-- map('n', '<leader>pr', "<CMD>lua require('telescope').extensions.gh.pull_request()<cr>", opts)
map('n', '<leader>pr', "<CMD>Octo pr list<cr>", opts)

-- Help me spell
map('n', '<leader>sp', "<CMD>lua require('telescope.builtin').spell_suggest()<CR>", opts)

-- Most Recently Used Files
map('n', 'mru', "<CMD>lua require('telescope').extensions.frecency.frecency()<CR>", opts)

return M
