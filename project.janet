(declare-project
  :name "getting-started" # required
  :description "a library that does things" # some example metadata.

  # Optional urls to git repositories that contain required artifacts.
  :dependencies ["https://github.com/janet-lang/json.git"
                 "https://github.com/joy-framework/joy"])

(declare-executable
 :name "myexec"
 :entry "src/server.janet")
