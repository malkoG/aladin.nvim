local _2afile_2a = "fnl/aladin-nvim/pickers.fnl"
local _2amodule_name_2a = "aladin-nvim.pickers"
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
local action_state, actions, api_client, config, entry_display, finders, pickers, previewers = autoload("telescope.actions.state"), autoload("telescope.actions"), autoload("aladin-nvim.api-client"), autoload("telescope.config"), autoload("telescope.pickers.entry_display"), autoload("telescope.finders"), autoload("telescope.pickers"), autoload("aladin-nvim.previewers")
do end (_2amodule_locals_2a)["action_state"] = action_state
_2amodule_locals_2a["actions"] = actions
_2amodule_locals_2a["api-client"] = api_client
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["entry_display"] = entry_display
_2amodule_locals_2a["finders"] = finders
_2amodule_locals_2a["pickers"] = pickers
_2amodule_locals_2a["previewers"] = previewers
local function make_display(entry)
  local columns
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for idx, attribute in ipairs({"itemId", "author", "title"}) do
      local val_19_auto
      if (idx == 1) then
        val_19_auto = {tostring(entry.book[attribute]), "TelescopeResultsNumber"}
      else
        val_19_auto = {(entry.book[attribute] or " ")}
      end
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    columns = tbl_17_auto
  end
  local displayer = entry_display.create({separator = " ", items = {{width = 10}, {width = 15}, {remaining = true}}})
  return displayer(columns)
end
_2amodule_locals_2a["make-display"] = make_display
local function make_book_entry()
  local function _3_(book)
    if not book then
      return nil
    else
      return {value = (book.title .. " " .. book.author), ordinal = (book.itemId .. " " .. book.author .. " " .. book.title .. " "), book = book, display = make_display}
    end
  end
  return _3_
end
_2amodule_2a["make-book-entry"] = make_book_entry
local function fetch_result(keyword)
  local _let_5_ = api_client["search-by-keyword"](keyword)
  local body = _let_5_["body"]
  return (vim.json.decode(string.sub(body, 1, -2))).item
end
_2amodule_locals_2a["fetch-result"] = fetch_result
local function paste_link(opts)
  local function _6_(prompt_bufnr)
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local title = selection.book.title
    local link = ("https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=" .. selection.book.itemId)
    local generated_link = ("[" .. title .. "]" .. "(" .. link .. ")")
    vim.api.nvim_put({generated_link}, "", true, true)
    return vim.api.nvim_feedkeys("A", "m", false)
  end
  return _6_
end
_2amodule_locals_2a["paste-link"] = paste_link
local function book_list_picker(opts)
  local conf = config.values
  local function _7_(_, map)
    map("i", "<c-i>", paste_link({}))
    map("n", "<c-i>", paste_link({}))
    map("i", "<c-cr>", paste_link({}))
    map("n", "<c-cr>", paste_link({}))
    return true
  end
  return pickers.new(opts, {previewer = previewers["book-list"].new(opts), sorter = conf.generic_sorter(opts), attach_mappings = _7_, finder = finders.new_dynamic({fn = fetch_result, entry_maker = make_book_entry()})}):find()
end
_2amodule_2a["book_list_picker"] = book_list_picker
return _2amodule_2a