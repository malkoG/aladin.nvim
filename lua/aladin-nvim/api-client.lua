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
local util = autoload("aladin-nvim.util")
do end (_2amodule_locals_2a)["util"] = util
local function curl_by_system_call(url)
  local curl = ("curl '" .. url .. "' -s" .. " -X GET" .. " -H 'Accept: application/json'" .. " -H 'Content-Type: application/json'")
  local jq_fields = "description, name, title, author, publisher, link, itemId"
  local extraction_filter = (" | {" .. jq_fields .. "}")
  local substring_filter = " | map(.description |= .[:20])"
  local jq_query = ("[.item[]" .. extraction_filter .. "]" .. substring_filter)
  local jq_filter = (" | jq '" .. jq_query .. "'")
  local escaping_filter = " | sed 's/\\\\[tn]//g'"
  local cliping_filter = " | rev | cut -c2- | rev "
  local full_command = (curl .. cliping_filter .. escaping_filter .. jq_filter)
  local handle = io.popen(full_command, "r")
  local response = handle:read("*a")
  handle.close()
  print(response)
  print(full_command)
  return {status = 200, body = response, headers = {}}
end
_2amodule_2a["curl-by-system-call"] = curl_by_system_call
local function search_by_keyword(keyword)
  local ttb_key = os.getenv("ALADIN_TTB_KEY")
  local url = ("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx" .. "?" .. "ttbkey=" .. ttb_key .. "&Query=" .. util.urlencode(keyword) .. "&MaxResults=10" .. "&SearchTarget=Book" .. "&output=js")
  return curl_by_system_call(url)
end
_2amodule_2a["search-by-keyword"] = search_by_keyword
return _2amodule_2a