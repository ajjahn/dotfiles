return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "NvimTreeToggle",
  },
  keys = {
    { "-", "<cmd>NvimTreeToggle<cr>" },
  },
  opts = {
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', '<ESC>', api.tree.close, opts('Close'))
      vim.keymap.set('n', '-', api.tree.toggle, opts('Toggle'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end,
    view = {
      float = {
        enable = true,
        quit_on_focus_loss = true,
        open_win_config = {
          width = 40,
          height = 60,
          row = 0,
          col = 0,
        },
      },
    }
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
