# Class: wordpress::mysql
#
# This class configures mysql for wordpress installation
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by wordpress
#
class wordpress::mysql inherits wordpress {

  case $wordpress::params::db_host {
    'localhost','127.0.0.1': {
      mysql::grant { "wordpress_server_grants_${::fqdn}":
        mysql_db         => $wordpress::params::db_name,
        mysql_user       => $wordpress::params::db_user,
        mysql_password   => $wordpress::params::db_password,
        mysql_privileges => 'ALL',
        mysql_host       => $wordpress::params::db_host,
      }
    }
    default: {
      # Automanagement of Mysql grants on external servers
      # requires StoredConfigs.
      @@mysql::grant { "wordpress_server_grants_${::fqdn}":
        mysql_db         => $wordpress::params::db_name,
        mysql_user       => $wordpress::params::db_user,
        mysql_password   => $wordpress::params::db_password,
        mysql_privileges => 'ALL',
        mysql_host       => $::fqdn,
        tag              => "mysql_grants_${wordpress::params::db_host}",
      }
    }
  }

}
