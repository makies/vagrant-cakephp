
app_name = 'cakephp'
app_config = node['app'][app_name]


include_recipe "database::postgresql"
package "phppgadmin"

# connection info
postgresql_connection_info = {:host => "127.0.0.1",
                              :port => 5432,
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']
}



# do the same but pass the provider to the database resource
database_user app_config['database']['user'] do
  connection postgresql_connection_info
  password app_config['database']['password']
  provider Chef::Provider::Database::PostgresqlUser
  action :create
end


# create a postgresql database
postgresql_database app_config['database']['database'] do
  connection postgresql_connection_info
  template 'DEFAULT'
  encoding 'DEFAULT'
  tablespace 'DEFAULT'
  # connection_limit '-1'
  owner app_config['database']['user']
  action :create
end


# grant select,update,insert privileges to all tables in foo db from all hosts
postgresql_database_user app_config['database']['user'] do
  connection postgresql_connection_info
  password app_config['database']['password']
  database_name app_config['database']['database']
  # host node['app']['database']['allow_host']
  # privileges node['app']['database']['privileges']
  privileges [:all]
  action :grant
end

