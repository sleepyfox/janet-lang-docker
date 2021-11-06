(import joy :prefix "")

(route :get "/" :home)

(defn home [request]
  (text/plain "You found joy!"))

(def app (app))

# This will be printed when you run `jpm build`
(print "build time!")

(defn main [& args]
    # You can also get command-line arguments through (dyn :args)
    (print "args: " ;(interpose ", " args))
    (server app 9001))
