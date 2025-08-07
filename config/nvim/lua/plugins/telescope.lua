local actions = require('telescope.actions')

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    -- config = function() require("_telescope") end,
    opts = {
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
        file_ignore_patterns = {},
        width = 0.75,
        preview_cutoff = 120,
        results_width = 0.8,
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

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
          fuzzy = false, -- false will only do exact matching, use fzy instead
        }
      },
    },
    cmd = {
      "Telescope",
    },
    keys = {
      {
        '<c-p>',
        function()
          local opts = {} -- define here if you want to define something
          local ok = pcall(require("telescope.builtin").git_files, opts)
          if not ok then require("telescope.builtin").find_files(opts) end
        end,
        desc = "Project Files",
      },

      { '<c-g>',       "<CMD>lua require('telescope.builtin').live_grep()<CR>" },
      { 'K',           "<CMD>lua require('telescope.builtin').grep_string()<CR>" },

      { '<space>rr',   "<CMD>lua require('telescope.builtin').resume()<CR>" },
      { '<space>jl',   "<CMD>lua require('telescope.builtin').jumplist()<CR>" },
      { '<space>qf',   "<CMD>lua require('telescope.builtin').quickfix()<CR>" },
      { '<space>reg',  "<CMD>lua require('telescope.builtin').registers()<CR>" },
      { '<leader>buf', "<CMD>lua require('telescope.builtin').buffers()<CR>n" },

      -- File Browser
      { '<leader>fb',  ":Telescope file_browser<CR>" },
      { '<leader>fbb', ":Telescope file_browser path=%:p:h select_buffer=true<CR>" },

      -- LSP Pickers
      { '<leader>gr',  "<CMD>lua require('telescope.builtin').lsp_references()<CR>" },

      -- Git Pickers
      {
        '<leader>gb',
        function()
          require("telescope.builtin").git_branches({
            attach_mappings = function(_, map)
              map('i', '<c-d>', actions.git_delete_branch)
              map('n', '<c-d>', actions.git_delete_branch)
              return true
            end
          })
        end,
        desc = "Git Branches",
      },
      { '<leader>gs', "<CMD>lua require('telescope.builtin').git_status()<CR>" },
      { '<leader>gc', "<CMD>lua require('telescope.builtin').git_commits()<CR>" },
      { '<leader>gl', "<CMD>lua require('telescope.builtin').git_bcommits()<CR>" },
      { '<leader>gw', "<CMD>lua require('telescope.builtin').git_stash()<CR>" },

      -- GitHub
      { '<leader>pr', "<CMD>lua require('telescope').extensions.gh.pull_request()<cr>" },
      -- { '<leader>pr', "<CMD>Octo pr list<cr>"},

      -- Help me spell
      { '<leader>sp', "<CMD>lua require('telescope.builtin').spell_suggest()<CR>" },

      -- Most Recently Used Files
      { 'mru',        "<CMD>lua require('telescope').extensions.frecency.frecency()<CR>" },
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*", -- install the latest stable version
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("telescope").load_extension("fzy_native")
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {
      { "nvim-telescope/telescope.nvim" }
    },
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    -- config = function()
    -- require("telescope").load_extension("fzf_native")
    -- end
  },
  { -- Replace by octo?
    "nvim-telescope/telescope-github.nvim",
    config = function()
      require("telescope").load_extension("gh")
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end
  },
}
