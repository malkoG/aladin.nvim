local _2afile_2a = "fnl/aladin-nvim/main.fnl"
local _2amodule_name_2a = "aladin-nvim.main"
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
local curl = autoload("plenary.curl")
do end (_2amodule_locals_2a)["curl"] = curl
local function init()
  return (1 + 2)
end
_2amodule_2a["init"] = init
local function search_book_from_aladin(keyword)
  local ttb_key = os.getenv("ALADIN_TTB_KEY")
  local url = ("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx" .. "?" .. "ttbkey=" .. ttb_key .. "&Query=" .. keyword .. "&QueryType=Title" .. "&MaxResults=10" .. "&SearchTarget=Book" .. "&output=js")
  return curl.get(url, {headers = {content_type = "application/json"}})
end
_2amodule_2a["search-book-from-aladin"] = search_book_from_aladin
return _2amodule_2a