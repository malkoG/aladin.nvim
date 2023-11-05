(module aladin-nvim.api-client-test 
  {autoload {s aniseed.string
  			 a aniseed.core
             api-client aladin-nvim.api-client}})

(deftest test-searching-elixir-has-at-least-one-record
  (let [result (api-client.search-by-keyword "elixir")]
    (let [{:status status :body body :headers headers} result]
      (t.= status 200 "Request is successful")
      (let [json-result (vim.json.decode (string.sub body 1 -2))]
        (print json-result)
        (t.ok? (not (= (length json-result) 0)) "Item is not nil")))))

(deftest test-searching-elixir-in-korean-has-at-least-one-record
  (let [result (api-client.search-by-keyword "엘릭서")]
    (let [{:status status :body body :headers headers} result]
      (t.= status 200 "Request is successful")
      (let [json-result (vim.json.decode (string.sub body 1 -2))]
        (t.ok? (not (= (length json-result) 0)) "Item is not nil")))))
