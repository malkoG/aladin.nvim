(module aladin-nvim.pickers
  {autoload {previewers aladin-nvim.previewers
             config telescope.config
             finders telescope.finders
             pickers telescope.pickers
             entry_display telescope.pickers.entry_display}})

(defn- make-display [entry]
  (let [columns (icollect [idx attribute (pairs [:itemId :title :content])] (if (= idx 1) [(. entry :book attribute) "TelescopeResultsNumber"] [(. entry :book attribute)]))
        displayer ((. entry_display :create)
                   {:separator " " :items [{:width 15} {:width 20} {:remaining true}]})]
    (displayer columns)))

(defn make-book-entry []
  (fn [book]
    (if 
      (not book) 
      nil 
      {:value (. book :title)
       :ordinal (.. (. book :itemId) " " (. book :title) " " (. book :content))
       :book book
       :display make-display})))

(defn book_list_picker [opts]
  (let [entries [{:title "aaabb111b" :itemId "12344" :content "Lorem Ipsum"} {:title "Good Job" :itemId "445566" :content "What"}]
        conf (. config :values)]
    (: ((. pickers :new) opts 
      {:previewer ((. previewers :book-list :new) opts)
       :sorter ((. conf :generic_sorter) opts)
       :finder ((. finders :new_table)
         {:results entries :entry_maker (make-book-entry)})}) :find)))
