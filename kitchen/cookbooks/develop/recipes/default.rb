#
# Cookbook Name:: develop
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe "vim"
include_recipe "emacs"
include_recipe "tmux"
include_recipe "screen"
include_recipe "ssh_known_hosts"
include_recipe "chef::client"

package "lv"
package "tree"
package "bash-completion"
