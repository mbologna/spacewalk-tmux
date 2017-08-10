#!/usr/bin/env ruby

SUMA_SERVER="suma31pg.tf.local"
SUMAFORM_DIR="/home/mbologna/Development/sumaform"
SPACEWALK_DIR="/home/mbologna/Development/spacewalk"
SPACEWALK_TMUXINATOR_CONFIG_DIR="/home/mbologna/.tmuxinator"
LSYNC_CONFIG_DIR="/home/mbologna"

lsync_js_template_config_file = "sync{
  default.rsyncssh, -- uses the rsyncssh defaults Take a look here: https://github.com/axkibe/lsyncd/blob/master/default-rsyncssh.lua
  delete = false, -- Doesn't delete files on the remote host eventho they're deleted at the source. This might be beneficial for some not for others
  source=\"#{SPACEWALK_DIR}/web/html/javascript\", -- Your source directory to watch
  host=\"#{SUMA_SERVER}\", -- The remote host (use hostname or IP)
  targetdir=\"/srv/www/htdocs/javascript\", -- the target dir on remote host, keep in mind this is absolute path
  rsync = {
    archive = true, -- use the archive flag in rsync
    perms = true, -- Keep the permissions
    owner = true, -- Keep the owner
    _extra = {\"-a\"}, -- Sometimes permissions and owners isn't copied correctly so the _extra can be used for any flag in rsync
  },
  delay = 3, -- We want to delay the syncing for 5 seconds so we queue up the events
  maxProcesses = 4, -- We only want to use a maximum of 4 rsync processes at same time
  ssh = {
    port = 22 -- This section allows configuration for ssh specific stuff such as a different port
  }
}"

lsync_css_template_config_file = "sync{
  default.rsyncssh, -- uses the rsyncssh defaults Take a look here: https://github.com/axkibe/lsyncd/blob/master/default-rsyncssh.lua
  delete = false, -- Doesn't delete files on the remote host eventho they're deleted at the source. This might be beneficial for some not for others
  source=\"#{SPACEWALK_DIR}/branding/css\", -- Your source directory to watch
  host=\"#{SUMA_SERVER}\", -- The remote host (use hostname or IP)
  targetdir=\"/srv/www/htdocs/css\", -- the target dir on remote host, keep in mind this is absolute path
  rsync = {
    archive = true, -- use the archive flag in rsync
    perms = true, -- Keep the permissions
    owner = true, -- Keep the owner
    _extra = {\"-a\"}, -- Sometimes permissions and owners isn't copied correctly so the _extra can be used for any flag in rsync
  },
  delay = 3, -- We want to delay the syncing for 5 seconds so we queue up the events
  maxProcesses = 4, -- We only want to use a maximum of 4 rsync processes at same time
  ssh = {
    port = 22 -- This section allows configuration for ssh specific stuff such as a different port
  }
}"

File.open(LSYNC_CONFIG_DIR + "/.lsync_js.conf", 'w') { |file| file.write(lsync_js_template_config_file) }
File.open(LSYNC_CONFIG_DIR + "/.lsync_css.conf", 'w') { |file| file.write(lsync_css_template_config_file) }
tmuxinator_template_config_file = "# ~/.tmuxinator/spacewalk.yml

name: spacewalk
root: ~
#tmux_command: byobu
startup_pane: 1

windows:
  - sumaform:
      layout: even-vertical
      panes:
        - cd #{SUMAFORM_DIR} && vim main.tf
        - cd #{SUMAFORM_DIR} && terraform plan
  - deploy:
      layout: tiled
      panes:
        - cd #{SPACEWALK_DIR}/java && vim buildconf/manager-developer-build.properties
        - cd #{SPACEWALK_DIR}/java && while echo \"Press Enter to deploy\" && read i; do ant -f manager-build.xml refresh-branding-jar deploy restart-tomcat -Ddeploy.host=#{SUMA_SERVER}; done
  - static-resources:
      layout: even-vertical
      panes:
        - cd #{SPACEWALK_DIR}/web/html/src && gulp devel-watch
        - lsyncd --nodaemon ~/.lsync_js.conf
        - lsyncd --nodaemon ~/.lsync_css.conf
  - test:
      layout: main-vertical
      panes:
        - cd #{SPACEWALK_DIR}/java && while echo \"Press Enter to test\" && read i; do ant -f manager-build.xml test ; done
        - cd #{SPACEWALK_DIR}/java && vim +6 buildconf/test/rhn.conf
        - cd #{SPACEWALK_DIR}/java && vim buildconf/manager-test-includes
        - cd #{SPACEWALK_DIR}/java && vim buildconf/manager-test-excludes
  - checkstyle:
        - cd #{SPACEWALK_DIR}/java && while echo \"Press Enter to checkstyle\" && read i; do ant -f manager-build.xml checkstyle ; done
  - git: cd #{SPACEWALK_DIR} && tig
  - sumaserver:
      layout: even-vertical
      panes:
        - ssh #{SUMA_SERVER}
        - ssh #{SUMA_SERVER} 'tail -F /var/log/rhn/*.log'"

Dir.mkdir(SPACEWALK_TMUXINATOR_CONFIG_DIR) unless File.exists?(SPACEWALK_TMUXINATOR_CONFIG_DIR)
File.open(SPACEWALK_TMUXINATOR_CONFIG_DIR + "/spacewalk.yml", 'w') { |file| file.write(tmuxinator_template_config_file) }
`tmuxinator start spacewalk`
