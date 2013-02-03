name             "app"
maintainer       "makies"
maintainer_email "makies@gmail.com"
license          "MIT License"
description      "Installs/Configures app"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends "apache2"
depends "php"
depends "mysql"
depends "postgresql"
depends "database"
