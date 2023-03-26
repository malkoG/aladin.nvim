local _2afile_2a = "fnl/aladin-nvim/util.fnl"
local _2amodule_name_2a = "aladin-nvim.util"
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
local function char_to_hex(c)
  return string.format("%%%02X", string.byte(c))
end
_2amodule_locals_2a["char-to-hex"] = char_to_hex
local function replace(text, pattern, target)
  return text:gsub(pattern, target)
end
_2amodule_locals_2a["replace"] = replace
local function urlencode(url)
  return replace(replace(replace(url, "\n", "\13\n"), "([^%w ])", char_to_hex), " ", "+")
end
_2amodule_2a["urlencode"] = urlencode
return _2amodule_2a