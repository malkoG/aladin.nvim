(module aladin-nvim.api-client
  {autoload {curl plenary.curl
             util aladin-nvim.util}})

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
      "&QueryType=Title"
      "&MaxResults=5"
      "&SearchTarget=Book"
      "&output=js"
    )]
    (curl.get url
      {:headers 
        {:content_type "application/json"}})))
