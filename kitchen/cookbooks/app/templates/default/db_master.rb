#
# Cookbook Name:: dicetrip
# Recipe:: db_master
#
# Copyright 2012, Jason Grimes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

app_name = 'dicetrip'
# app_secrets = Chef::EncryptedDataBagItem.load("secrets", app_name) 

# Get mysql root password
# mysql_secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")
# mysql_root_pass = mysql_secrets[node.chef_environment]['root'] 
mysql_root_pass = node['mysql']['server_root_password']


# Create application database
ruby_block "create_#{app_name}_db" do
  block do
    %x[mysql -uroot -p#{mysql_root_pass} -e "CREATE DATABASE #{node[app_name]['db_name']};"]
  end 
  not_if "mysql -uroot -p#{mysql_root_pass} -e \"SHOW DATABASES LIKE '#{node[app_name]['db_name']}'\" | grep #{node[app_name]['db_name']}";
  action :create
end

# Get a list of web servers
webservers = node['roles'].include?('webserver') ? [{'ipaddress' => 'localhost'}] : search(:node, "role:webserver AND chef_environment:#{node.chef_environment}")

# Grant mysql privileges for each web server 
# webservers.each do |webserver|
  # ip = webserver['ipaddress']
  # ruby_block "add_#{ip}_#{app_name}_permissions" do
	block do
      %x[mysql -u root -p#{mysql_root_pass} -e "GRANT SELECT,INSERT,UPDATE,DELETE \
        ON #{node[app_name]['db_name']}.* TO '#{node[app_name][:db_user]}'@'#{ip}' IDENTIFIED BY '#{node[app_name]['db_pass']}';"]
    end
    not_if "mysql -u root -p#{mysql_root_pass} -e \"SELECT user, host FROM mysql.user\" | \
      grep #{node[app_name]['db_user']} | grep #{ip}"
    action :create
  # end
# end
