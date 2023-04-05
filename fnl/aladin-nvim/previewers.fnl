(module aladin-nvim.previewers 
  {autoload {writers aladin-nvim.writers
             previewers telescope.previewers
             pv-utils telescope.previewers.utils 
             ts-utils telescope.utils}})

(local defaulter ts-utils.make_defalt_callable) 

(defn- book-list-previewer [opts]
  (previewers.new_buffer_previewer {
    :title "Aladin에서 책 이름 검색"
    :get_buffer_by_name (fn [_ entry] (. entry :value))
    :define_preview 
      (fn [self entry] 
        (let [bufnr (. self :state :bufnr)
              bufname (. self :state :bufname)]
          (if (or 
            (~= bufname (. entry :value))
            (= (vim.api.nvim_buf_line_count bufnr) 1))
              (do
                (writers.flush-buffer bufnr)
                (writers.write-line bufnr [(tostring (. entry :book :itemId))] nil)
                (writers.write-line bufnr [(. entry :book :author)] nil)
                (writers.write-line bufnr [(. entry :book :title)] nil)
                (writers.write-line bufnr [(or (. entry :book :description) " ")] nil))  
              (do
                (writers.flush-buffer bufnr)
                (writers.write-line bufnr [(tostring (. entry :book :itemId))] nil)
                (writers.write-line bufnr [(. entry :book :author)] nil)
                (writers.write-line bufnr [(. entry :book :title)] nil)
                (writers.write-line bufnr [(or (. entry :book :description) " ")] nil)))
        ))
    }))

(def book-list
  (ts-utils.make_default_callable book-list-previewer))
