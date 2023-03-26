local _2afile_2a = "fnl/aladin-nvim/previewers.fnl"
local _2amodule_name_2a = "aladin-nvim.previewers"
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
local autoload = (require("aniseed.autoload")).autoload
local previewers, pv_utils, ts_utils, writers = autoload("telescope.previewers"), autoload("telescope.previewers.utils"), autoload("telescope.utils"), autoload("aladin-nvim.writers")
do end (_2amodule_locals_2a)["previewers"] = previewers
_2amodule_locals_2a["pv-utils"] = pv_utils
_2amodule_locals_2a["ts-utils"] = ts_utils
_2amodule_locals_2a["writers"] = writers
local defaulter = ts_utils.make_defalt_callable
local function book_list_previewer(opts)
  local function _1_(_, entry)
    return entry.value
  end
  local function _2_(self, entry)
    local bufnr = self.state.bufnr
    local bufname = self.state.bufname
    if ((bufname ~= entry.value) or (vim.api.nvim_buf_line_count(bufnr) == 1)) then
      writers["flush-buffer"](bufnr)
      writers["write-line"](bufnr, {entry.book.itemId}, nil)
      return writers["write-line"](bufnr, {entry.book.title}, nil)
    else
      writers["flush-buffer"](bufnr)
      writers["write-line"](bufnr, {entry.book.itemId}, nil)
      return writers["write-line"](bufnr, {entry.book.title}, nil)
    end
  end
  return previewers.new_buffer_previewer({title = "Aladin\236\151\144\236\132\156 \236\177\133 \236\157\180\235\166\132 \234\178\128\236\131\137", get_buffer_by_name = _1_, define_preview = _2_})
end
_2amodule_locals_2a["book-list-previewer"] = book_list_previewer
local book_list = ts_utils.make_default_callable(book_list_previewer)
do end (_2amodule_2a)["book-list"] = book_list
return _2amodule_2a