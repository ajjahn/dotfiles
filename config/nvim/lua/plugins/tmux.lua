return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>",  "<cmd>TmuxNavigateLeft<cr>",     mode = { "v", "n" } },
    { "<c-j>",  "<cmd>TmuxNavigateDown<cr>",     mode = { "v", "n" } },
    { "<c-k>",  "<cmd>TmuxNavigateUp<cr>",       mode = { "v", "n" } },
    { "<c-l>",  "<cmd>TmuxNavigateRight<cr>",    mode = { "v", "n" } },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "v", "n" } },
  },
}
