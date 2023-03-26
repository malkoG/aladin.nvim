local _2afile_2a = "fnl/aladin-nvim/writers.fnl"
local _2amodule_name_2a = "aladin-nvim.writers"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local function flush_buffer(bufnr)
  local bufnr0 = (bufnr or vim.api.nvim_get_current_buf)
  return vim.api.nvim_buf_set_lines(bufnr0, 0, -1, false, {})
end
_2amodule_2a["flush-buffer"] = flush_buffer
local function write_line(bufnr, lines, line)
  local bufnr0 = (bufnr or vim.api.nvim_get_current_buf)
  local line0 = (line or (vim.api.nvim_buf_line_count(bufnr0) + 1))
  return vim.api.nvim_buf_set_lines(bufnr0, (line0 - 1), ((line0 - 1) + #lines), false, lines)
end
_2amodule_2a["write-line"] = write_line
return _2amodule_2a