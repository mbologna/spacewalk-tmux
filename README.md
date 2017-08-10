# Tmuxinated setup for Spacewalk development

## Introduction

## Dependencies

* ruby (`sudo zypper in ruby`)
* tmuxinator (`sudo gem install tmuxinator`)
* lsyncd (`sudo zypper in lsyncd`)
* gulp (`sudo npm install -g gulp`)
* tig (`sudo zypper in tig`)
* [sumaform](https://github.com/moio/sumaform)
* SUSE Manager or spacewalk

## Usage

* Download `spacewalk-tmux.rb` and place it in your PATH (`~/bin`)
* Edit the following variables in `spacewalk-tmux.rb` adjust values accordingly:

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
