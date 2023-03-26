(module aladin-nvim.util)

(defn- char-to-hex [c]
  (string.format "%%%02X" (string.byte c)))

(defn- replace [text pattern target]
  (: text :gsub pattern target))

(defn urlencode [url]
  (-> url 
    (replace "\n" "\r\n")
    (replace "([^%w ])" char-to-hex)
    (replace " " "+")))
