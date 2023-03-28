(module aladin-nvim.pickers
  {autoload {previewers aladin-nvim.previewers
             api-client aladin-nvim.api-client
             config telescope.config
             finders telescope.finders
             pickers telescope.pickers
             entry_display telescope.pickers.entry_display}})

(defn- make-display [entry]
  (let [columns (icollect [idx attribute (ipairs [:itemId :title :description])] (if (= idx 1) [(tostring (. entry :book attribute)) "TelescopeResultsNumber"] [(or (. entry :book attribute) " ")]))
        displayer ((. entry_display :create)
                   {:separator " " :items [{:width 15} {:width 30} {:remaining true}]})]
    (displayer columns)))

(defn make-book-entry []
  (fn [book]
    (if 
      (not book) 
      nil 
      {:value (. book :title)
       :ordinal (.. (. book :itemId) " " (. book :title) " ")
       :book book
       :display make-display})))

(defn- prompt-keyword []
  (vim.fn.input {:prompt "검색할 책의 이름을 입력해주세요: "}))

(defn- fetch-result [keyword]
  (let [{:body body} (api-client.search-by-keyword keyword)]
    (. (vim.json.decode (string.sub body 1 -2)) :item)))

(defn book_list_picker [opts]
  (let [entries (fetch-result (prompt-keyword))
        conf (. config :values)]
    (: ((. pickers :new) opts 
      {:previewer ((. previewers :book-list :new) opts)
       :sorter ((. conf :generic_sorter) opts)
       :finder ((. finders :new_table)
         {:results entries :entry_maker (make-book-entry)})}) :find)))
