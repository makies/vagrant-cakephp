
app_name = 'cakephp'
app_config = node['app'][app_name]

include_recipe "database::mysql"

package "phpmyadmin" do
	[:install, :update]
end


# mysql connection
mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}



# mysql create database
mysql_database app_config['database']['database'] do
  connection mysql_connection_info
  action :create
end


# grant select,update,insert privileges to all tables in foo db from all hosts
mysql_database_user app_config['database']['user'] do
  connection mysql_connection_info
  password app_config['database']['password']
  database_name app_config['database']['database']
  host app_config['database']['allow_host']
end


