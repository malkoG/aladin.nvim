(module aladin-nvim.api-client
  {autoload {util aladin-nvim.util}})

(defn curl-by-system-call [url]
  (let [
    curl (.. "curl '" url "' -s" " -X GET" " -H 'Accept: application/json'" " -H 'Content-Type: application/json'")
    jq-fields "description, name, title, author, publisher, link, itemId"
    extraction-filter (.. " | {" jq-fields "}")
    substring-filter " | map(.description |= .[:20])"
    jq-query (.. "[.item[]" extraction-filter "]" substring-filter)
    jq-filter (.. " | jq '" jq-query "'")
    escaping-filter " | sed 's/\\\\[tn]//g'"
    cliping-filter " | rev | cut -c2- | rev "
    full-command (.. curl cliping-filter escaping-filter jq-filter)
    handle ((. io :popen) full-command "r")
    response (: handle :read "*a")
  ]
    ((. handle :close))
    ; (print response)
    ; (print full-command)

    {:status 200 
     :body response
     :headers {}}
  )
)

(defn search-by-keyword [keyword]
  (let [
    ttb-key (os.getenv "ALADIN_TTB_KEY")
    url (
      ..
      "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx"
      "?"
      "ttbkey="
      ttb-key
      "&Query="
      (util.urlencode keyword)
      "&MaxResults=10"
      "&SearchTarget=Book"
      "&output=js"
    )]
    (curl-by-system-call url)))
