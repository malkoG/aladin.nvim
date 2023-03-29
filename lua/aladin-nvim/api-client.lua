local _2afile_2a = "fnl/aladin-nvim/api-client.fnl"
local _2amodule_name_2a = "aladin-nvim.api-client"
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
local curl, util = autoload("plenary.curl"), autoload("aladin-nvim.util")
do end (_2amodule_locals_2a)["curl"] = curl
_2amodule_locals_2a["util"] = util
local function search_by_keyword(keyword)
  local ttb_key = os.getenv("ALADIN_TTB_KEY")
  local url = ("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx" .. "?" .. "ttbkey=" .. ttb_key .. "&Query=" .. util.urlencode(keyword) .. "&QueryType=Title" .. "&MaxResults=5" .. "&SearchTarget=Book" .. "&output=js")
  return curl.get(url, {headers = {content_type = "application/json"}})
end
_2amodule_2a["search-by-keyword"] = search_by_keyword
return _2amodule_2a