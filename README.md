# Usage

Update the `JANET_VERSION` variable in the Makefile to be that for which you want
to build the docker image (see https://github.com/janet-lang/janet/releases for available
releases).

You can now build a Docker runtime container image with: `make build` and bring up a repl with: `make repl`.
To quit from the repl use ^d or `(os/exit)`.
