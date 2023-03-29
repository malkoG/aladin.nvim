-- Default keympaps
if vim.g.aladin_no_default_keymaps then
  return
end

vim.api.nvim_create_user_command("AladinSearch", require("aladin-nvim.pickers").book_list_picker, {})

local default_keymaps = {
  { 'n', '<leader>al', ':lua require("aladin-nvim.pickers").book_list_picker({})<CR>' },
}

for _, t in ipairs(default_keymaps) do
  local mode = t[1]
  local lhs = t[2]
  local rhs = t[3]
  -- User has not mapped (a keyseq starting with) `lhs` to something else.
  -- User has not already mapped something to the <Plug> key.
  -- if vim.fn.mapcheck(lhs, mode) == "" and vim.fn.hasmapto(rhs, mode) == 0 then
  vim.keymap.set(mode, lhs, rhs, {silent = true})
  -- end
end
