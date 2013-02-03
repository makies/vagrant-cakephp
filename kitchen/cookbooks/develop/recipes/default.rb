#
# Cookbook Name:: develop
# Recipe:: default
#
# Copyright 2013, makies
#
# 開発環境独自のRecipe読み込み、パッケージインストール

include_recipe "vim"
include_recipe "tmux"

package "lv"
package "tree"
package "bash-completion"
