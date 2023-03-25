(module aladin-nvim.main
  {autoload {curl plenary.curl}})

(defn init []
  (+ 1 2))

(defn search-book-from-aladin [keyword]
  (let [
    ttb-key (os.getenv "ALADIN_TTB_KEY")
    url (
      ..
      "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx"
      "?"
      "ttbkey="
      ttb-key
      "&Query="
      keyword
      "&QueryType=Title"
      "&MaxResults=10"
      "&SearchTarget=Book"
      "&output=js"
    )]
    (curl.get url
      {:headers 
        {:content_type "application/json"}})))
