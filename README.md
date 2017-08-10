# Tmuxinated setup for SUSE Manager development

![Demo in action](demo/spacewalk-tmux.json.gif)

## Introduction

This automated setup creates a tmux environment suitable for developing SUSE Manager (or spacewalk).
Upon launching, you will be prompted with a tmux session that comprises:
  * A sumaform configuration editor and prompt to provision it
  * A Java remote deployment (press Enter to deploy)
  * A front-end static-resources automated deployer (with `gulp` and `lsyncd`)
  * A JUnit test runner (press Enter to launch tests) with configuration editor
  * A Checkstyle runner (press Enter to checkstyle)
  * A tig client to access SCM
  * A SSH window inside the development server with a split window `tail`ed on logs

## Dependencies

* [sumaform](https://github.com/moio/sumaform)
* SUSE Manager or spacewalk sources
* ruby
* tmux
* lsyncd
* nodejs
* tig
* tmuxinator
* gulp

## Dependencies: copy-paste for OpenSUSE

```
$ git clone git@github.com:moio/sumaform.git
$ git clone git@github.com:SUSE/spacewalk.git
$ sudo zypper in ruby tmux lsyncd nodejs tig
$ sudo gem install tmuxinator
$ sudo npm install -g gulp
```

## Usage: human version

1. Clone the project:
  ```
  $ git clone git@github.com:mbologna/spacewalk-tmux.git && cd spacewalk-tmux
  ```
2. Create a symlink somewhere in your PATH (personal preference: `~/bin`):
  ```
  $ ln -s `pwd`/spacewalk-tmux ~/bin/spacewalk-tmux
  ```
3. Edit the following variables in `spacewalk-tmux` adjusting the self-explanatory values accordingly:
  ```
  SUMA_SERVER = 'suma31pg.tf.local'
  SUMAFORM_DIR = '/home/mbologna/Development/sumaform'
  SPACEWALK_DIR = '/home/mbologna/Development/spacewalk'
  SPACEWALK_TMUXINATOR_CONFIG_DIR = '/home/mbologna/.tmuxinator'
  LSYNC_CONFIG_DIR = '/home/mbologna'
  ```
4. Launch tmux via `$ spacewalk-tmux`
5. Happy coding!

## Usage: TL;DR (robot) version

1. Clone sumaform and SUSE Manager (or spacewalk).
2. Install `spacewalk-tmux`:
  ```
  $ git clone git@github.com:mbologna/spacewalk-tmux.git
  $ cd spacewalk-tmux
  $ ln -s `pwd`/spacewalk-tmux ~/bin/spacewalk-tmux
  $ vim ~/bin/spacewalk-tmux # change values
  $ spacewalk-tmux
  ```

## Contributing

1. Think of your setup: is there anything missing in `spacewalk-tmux`?
2. Fork the project
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
