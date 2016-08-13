resir014-tilde
==============

> Source code for [my tilde site](https://tilde.town/~resir014/).

Developing
----------

Requirements:
* Git
* Ruby (v2.0.0+)
* Bundler
  (included from within Rails (`gem install rails`) or `gem install bundler`)
* Jekyll <http://jekyllrb.com/>
  (install from within Ruby: `gem install jekyll`)

Clone it. ( `git clone https://github.com/resir014/resir014-tilde.git` )

Then install all the bundled plugins.

```bash
$ bundle install
```

After the plugins are installed, we can now run a local server from within our computer.

```bash
$ bundle exec jekyll serve
```

Deploy process
--------------

**NOTE:** The deploy script included in this repository *only* works from within the server! You should ssh into the server and clone the project there before running the deploy script.

To deploy the site, run this command.

```bash
# Run this command from the server
$ tasks/deploy.sh
```

Special thanks
--------------

* Poole: [@mdo](https://twitter.com/mdo)
* Hosting: [tilde.town](https://tilde.town)
* Design: [@resir014](https://twitter.com/resir014)

See [`third-party.txt`](https://github.com/resir014/resir014-tilde/blob/master/third-party.txt) for third-party license notices.
