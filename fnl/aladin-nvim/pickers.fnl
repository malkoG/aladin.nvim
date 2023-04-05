(module aladin-nvim.pickers
  {autoload {previewers aladin-nvim.previewers
             api-client aladin-nvim.api-client
             config telescope.config
             finders telescope.finders
             pickers telescope.pickers
             actions telescope.actions
             action_state telescope.actions.state
             entry_display telescope.pickers.entry_display}})

(defn- make-display [entry]
  (let [columns (icollect [idx attribute (ipairs [:itemId :author :title])] (if (= idx 1) [(tostring (. entry :book attribute)) "TelescopeResultsNumber"] [(or (. entry :book attribute) " ")]))
        displayer ((. entry_display :create)
                   {:separator " " :items [{:width 10} {:width 15} {:remaining true}]})]
    (displayer columns)))

(defn make-book-entry []
  (fn [book]
    (if 
      (not book) 
      nil 
      {:value (.. (. book :title) " " (. book :author))
       :ordinal (.. (. book :itemId) " " (. book :author) " " (. book :title) " ")
       :book book
       :display make-display})))

(defn- fetch-result [keyword]
  (let [{:body body} (api-client.search-by-keyword keyword)]
    (. (vim.json.decode (string.sub body 1 -2)) :item)))

(defn- paste-link [opts]
  (fn [prompt-bufnr]
    ((. actions :close) prompt-bufnr)
    (let [selection ((. action_state :get_selected_entry))
          title (. selection :book :title)
          item-id (. selection :book :itemId
          link (.. "https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=" item-id)
          generated-link (.. "[" title "]" "(" link ")")]
      (vim.api.nvim_put [generated-link] "" true true)
      (vim.api.nvim_feedkeys "A" "m" false))))

(defn book_list_picker [opts]
  (let [conf (. config :values)]
    (: ((. pickers :new) opts 
      {:previewer ((. previewers :book-list :new) opts)
       :sorter ((. conf :generic_sorter) opts)
       :attach_mappings 
        (fn [_ map]
          (map "i" "<c-i>" (paste-link {}))
          (map "n" "<c-i>" (paste-link {}))
          (map "i" "<c-cr>" (paste-link {}))
          (map "n" "<c-cr>" (paste-link {}))
          true)
       :finder ((. finders :new_dynamic)
         {:fn fetch-result :entry_maker (make-book-entry)})}) :find)))
