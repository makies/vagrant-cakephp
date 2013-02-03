# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "ubuntu1210_amd64.box"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    config.vm.box_url = "https://www.dropbox.com/s/3fz83xlc9l1cbmj/ubuntu1210_amd64.box"

    # Boot with a GUI so you can see the screen. (Default is headless)
    # config.vm.boot_mode = :gui

    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP. Host-only networks can talk to the host machine as well as
    # any other machines on the same network, but cannot be accessed (through this
    # network interface) by any external networks.
    # config.vm.network :bridged
    config.vm.network :hostonly, "192.168.40.19"

    # Assign this VM to a bridged network, allowing you to connect directly to a
    # network using the host's network device. This makes the VM appear as another
    # physical device on your network.
    # config.vm.network :bridged

    # Forward a port from the guest to the host, which allows for outside
    # computers to access the VM, whereas host only networking does not.
    # config.vm.forward_port 80, 8080

    # Share an additional folder to the guest VM. The first argument is
    # an identifier, the second is the path on the guest to mount the
    # folder, and the third is the path on the host to the actual folder.
    # config.vm.share_folder "v-data", "/vagrant_data", "../data"
    config.vm.share_folder "app", "/app", "../app" ,:create => true, :nfs => false


    # Enable provisioning with chef solo, specifying a cookbooks path, roles
    # path, and data_bags path (all relative to this Vagrantfile), and adding 
    # some recipes and/or roles.
    #
    # config.vm.provision :chef_solo do |chef|
    #   chef.cookbooks_path = "../my-recipes/cookbooks"
    #   chef.roles_path = "../my-recipes/roles"
    #   chef.data_bags_path = "../my-recipes/data_bags"
    #   chef.add_recipe "mysql"
    #   chef.add_role "web"
    #
    #   # You may also specify custom JSON attributes:
    #   chef.json = { :mysql_password => "foo" }
    # end
    config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ["kitchen/cookbooks", "kitchen/opscode"]
        chef.json = {
            :fqdn => 'cakephp',
            :hostname => 'cakephp-dev',
            :chef_environment => 'dev',
            :postgresql => {
            :password => {
            :postgres => "pgsql"
        }
        },
            :mysql => {
            :server_root_password => 'mysql',
            :server_repl_password => 'mysql',
            :server_debian_password => 'mysql'
        },
            :apache => {
            :user => 'vagrant',
            :group => 'vagrant',
            :document_root => '/app',
            :allow_override => 'all',
            :log_dir => '/var/log/apache2'
        },
            :app => {
            'cakephp' => {
            :appname => 'cakephp',
            :server_name => 'cakephp.example.com',
            :docroot => '/app',
            :database => {
            :datasource => 'Database/Postgres',
            :database => 'cake',
            :user => 'cake',
            :password => 'password',
            :port => 5432,
            :allow_host => 'localhost'
        },
            :database_config_path => '/app/app/Config/database.php'
        }
        }
        }
        chef.add_recipe "apt"
        chef.add_recipe "ubuntu"
        chef.add_recipe "chef-client"
        chef.add_recipe "develop"
        chef.add_recipe "app"
        chef.log_level = :debug
    end
end
