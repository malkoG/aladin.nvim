(module aladin-nvim.main-test 
  {autoload {s aniseed.string
  			 a aniseed.core}})

(deftest something-simple
  (t.= 1 1 "1 should equal 1, I hope!"))

(deftest hello-world
  (t.= 2 2 "2 should equal 2, I hope!"))
