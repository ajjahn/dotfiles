local vim = vim

local npairs = require("nvim-autopairs")
npairs.setup()

-- clear all rule if you don"t want to use autopairs
--npairs.clear_rules()
local endwise = require("nvim-autopairs.ts-rule").endwise

npairs.add_rules({
  -- then$ is a lua regex
  -- end is a match pair
  -- lua is a filetype
  -- if_statement is a treesitter name. set it = nil to skip check with treesitter
  endwise("then$", "end", "lua", "if_statement"),
})


local remap = vim.api.nvim_set_keymap
-- skip it, if you use another global object
_G.MUtils = {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end


remap("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })
