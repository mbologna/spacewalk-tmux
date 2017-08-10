# Tmuxinated setup for Spacewalk development

## Introduction

This automated setup creates a tmux environment suitable for developing SUSE Manager and spacewalk.

## Dependencies

* ruby
* tmux
* lsyncd
* nodejs
* tig (`sudo zypper in tig`)
* tmuxinator (`sudo gem install tmuxinator`)
* gulp (`sudo npm install -g gulp`)
* [sumaform](https://github.com/moio/sumaform)
* SUSE Manager or spacewalk

## TL;DR

1. Checkout sumaform and spacewalk
2. ```
$ sudo zypper in ruby lsyncd nodejs tmux tig
$ sudo gem install tmuxinator
$ sudo npm install -g gulp
$ git clone git@github.com:mbologna/spacewalk-tmux.git 
$ cd spacewalk-tmux
$ ln -s `pwd`/spacewalk-tmux ~/bin/spacewalk-tmux
$ vim `which spacewalk-tmux`
$ spacewalk-tmux
```

## Usage

* Download `spacewalk-tmux` and place it somewhere in your PATH (personal preference: `~/bin`)
* Edit the following variables in `spacewalk-tmux` adjusting values accordingly:

```
SUMA_SERVER="suma31pg.tf.local"
SUMAFORM_DIR="/home/mbologna/Development/sumaform"
SPACEWALK_DIR="/home/mbologna/Development/spacewalk"
SPACEWALK_TMUXINATOR_CONFIG_DIR="/home/mbologna/.tmuxinator"
LSYNC_CONFIG_DIR="/home/mbologna"
```

* Start coding:

```$ spacewalk-tmux```

* Happy coding!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
