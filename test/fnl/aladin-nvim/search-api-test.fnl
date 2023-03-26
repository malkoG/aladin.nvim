(module aladin-nvim.search-api-test 
  {autoload {s aniseed.string
  			 a aniseed.core
             main aladin-nvim.main}})

(deftest test-searching-elixir-has-at-least-one-record
  (let [result (main.search-book-from-aladin "elixir")]
    (let [{:status status :body body :headers headers} result]
      (t.= status 200 "Request is successful")
      ; (print body)
      (let [json-result (vim.json.decode (string.sub body 1 -2))]
        ; (each [k v (pairs json-result)]
        ;   (print k))
        (t.ok? (a.get-in json-result [:item]) "Item is not nil")))))

(deftest test-searching-elixir-in-korean-has-at-least-one-record
  (let [result (main.search-book-from-aladin "엘릭서")]
    (let [{:status status :body body :headers headers} result]
      (t.= status 200 "Request is successful")
      ; (print body)
      (let [json-result (vim.json.decode (string.sub body 1 -2))]
        ; (each [k v (pairs json-result)]
        ;   (print k))
        (t.ok? (a.get-in json-result [:item]) "Item is not nil")))))
