(module aladin-nvim.writers)

(defn flush-buffer [bufnr]
  (let [bufnr (or bufnr vim.api.nvim_get_current_buf)]
    (vim.api.nvim_buf_set_lines bufnr 0 -1 false {})))

(defn write-line [bufnr lines line]
  (let [bufnr (or bufnr vim.api.nvim_get_current_buf)
        line (or line (+ (vim.api.nvim_buf_line_count bufnr) 1))]
    (vim.api.nvim_buf_set_lines 
      bufnr
      (- line 1)
      (+ (- line 1) (length lines))
      false
      lines)))
