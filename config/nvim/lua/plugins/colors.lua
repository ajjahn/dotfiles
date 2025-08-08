local vim = vim

return {
  'sainnhe/everforest',
  init = function()
    vim.cmd [[set background=dark]]
    vim.g.everforest_background = 'soft'
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_dim_inactive_windows = 1
    vim.cmd [[
        let g:everforest_colors_override = {'bg0': ['#2E373D', '235']}
    ]]
    vim.cmd [[colorscheme everforest]]
  end
}
