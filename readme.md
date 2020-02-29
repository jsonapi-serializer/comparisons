# Ruby JSON:API serialization performance comparisons

An automated suite of tests to explore the performance of the JSON:API
serialization implementations in Ruby.

The frameworks selection requirements:
 * maintained (recent releases, activity in PRs or issues)
 * have some popularity (send PRs if you still want it here)
 * be a library (we're not testing web frameworks here)

To start the benchmarks, run:

```
$ docker run --rm -v `pwd`:/app -w /app -it -e RUBYOPT=-W:no-deprecated ruby:2.7-alpine sh -c 'apk add git build-base && bundle && benchmark-driver ./all.yml --bundler'
```
