#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


app_name = 'cakephp'
app_config = node['app'][app_name]

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_php5"
include_recipe "php"
include_recipe "php::module_apc"
include_recipe "php::module_curl"
include_recipe "php::module_memcache"

# MySQL
# include_recipe "mysql::server"
# include_recipe "php::module_mysql"
# include_recipe "app::mysql"

# postgreSQL
include_recipe "postgresql::server"
include_recipe "php::module_pgsql"
include_recipe "app::pgsql"


# app側DB設定
template app_config['database_config_path'] do
	source "database.php.erb"
	datasource = app_config['database']['datasource']
	host = app_config['database']['host']
	port = app_config['database']['port']
	user = app_config['database']['user']
	password = app_config['database']['password']
	prefix = app_config['database']['prefix']
	database = app_config['database']['database']
	encoding = app_config['database']['encoding']
	presistent = app_config['database']['presistent']
	user "vagrant"
	group "vagrant"
	mode 0644
	:create
end


# Set up the Apache virtual host
web_app app_name do
  template "vhost.conf.erb"
  server_name app_config['server_name']
  docroot app_config['docroot']
  log_dir node['apache']['log_dir']
end
