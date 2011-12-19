# Class: wordpress::params
#
# This class defines default parameters used by the main module class wordpress
# Operating Systems differences in names and paths are addressed here 
#
# == Variables
# 
# Refer to wordpress class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It may be imported or inherited by other classes
#
class wordpress::params {

  # Default installation type depends on OS package availability
  $install = $::wordpress_install ? {
    ''      => "package",          # Default value
    default => $::wordpress_install,
  }

  # Install source from the upstream provider is updated to module's last update time
  # You may need to change this: use the "install_source" parameter of the wordpress class
  $install_source = $::wordpress_install_source ? {
    ''      => "http://wordpress.org/latest.zip",    # Default value
    default => $::wordpress_install_source,
  }
 
  $install_destination = $::wordpress_install_destination ? {
    ''      => $operatingsystem ? {
               /(?i:Debian|Ubuntu|Mint)/ => "/var/www",
               /(?i:Suse|OpenSuse)/      => "/srv/www",
               default                   => "/var/www/html",
               }, # Default value calculated according to $operatingsystem 
    default => $::wordpress_install_destination,
  }

  $install_precommand = $::wordpress_install_precommand ? {
    ''      => "",                   # Default value
    default => $::wordpress_install_precommand,
  } 

  $install_postcommand = $::wordpress_install_postcommand ? {
    ''      => "",                   # Default value
    default => $::wordpress_install_postcommand,
  }

  $url_check = $::wordpress_url_check ? {
    ''      => "",                   # Default value
    default => $::wordpress_url_check,
  }

  $url_pattern = $::wordpress_url_pattern ? {
    ''      => "OK",                 # Default value
    default => $::wordpress_url_pattern,
  } 

  $web_server = $::wordpress_web_server ? {
    ''      => $::web_server ? {
      ""      => "",                 # Default value
      default => $::web_server,
    },
    default => $::wordpress_web_server,
  } 

  $web_server_template = $::wordpress_web_server_template ? {
    ''      => "",                   # Default value
    default => $::wordpress_web_server_template,
  }

  $web_virtualhost = $::wordpress_web_virtualhost ? {
    ''      => "wordpress.$domain",  # Default value
    default => $::wordpress_web_virtualhost,
  }

  $db_type = $::wordpress_db_type ? {
    ''      => "mysql",              # Default value
    default => $::wordpress_db_type,
  }

  $db_host = $::wordpress_db_host ? {
    ''      => "localhost",          # Default value
    default => $::wordpress_db_host,
  }

  $db_name = $::wordpress_db_name ? {
    ''      => "wordpress",          # Default value
    default => $::wordpress_db_name,
  }

  $db_user = $::wordpress_db_user ? {
    ''      => "wordpress",          # Default value
    default => $::wordpress_db_user,
  }

  # We precalculate a random password
  $wordpress_random_password = fqdn_rand(100000000000) 

  $db_password = $::wordpress_db_password ? {
    ''      => $wordpress_random_password,  # Default value
    default => $::wordpress_db_password,
  }

  $package = $operatingsystem ? {
    default => "wordpress",
  }

  $config_dir = $wordpress::install ? {
    package => $operatingsystem ? {
      default => "/etc/wordpress",
    },
    default => "$install_destination",
  }

  $config_file = $wordpress::install ? {
    package => $operatingsystem ? {
      default => "/etc/wordpress/wp-config.php",
    },
    default => "$install_destination/wp-config.php", 
  } 

  $config_file_mode = $operatingsystem ? { 
    default => "0644",
  }

  $config_file_owner = $operatingsystem ? {
    default => "root",
  }

  $config_file_group = $operatingsystem ? {
    default => "root",
  }

  $data_dir = $wordpress::install ? {
    package => $operatingsystem ? {
      default => "/usr/share/wordpress",
    },
    default => "$install_destination",
  }

  $log_dir = $operatingsystem ? {
    default => "",
  }

  $log_file = $operatingsystem ? {
    default => "",
  }


  ### General variables that affect module's behaviour
  # They can be set at top scope level or in a ENC

  $my_class = $::wordpress_my_class ? {
    ''      => "",                      # Default value
    default => $::wordpress_my_class,
  }

  $source = $::wordpress_source ? {
    ''      => "",                      # Default value
    default => $::wordpress_source,
  }

  $source_dir = $::wordpress_source_dir ? {
    ''      => "",                      # Default value
    default => $::wordpress_source_dir,
  }

  $source_dir_purge = $::wordpress_source_dir_purge ? {
    ''      => false,                   # Default value
    default => $::wordpress_source_dir_purge,
  }

  $template = $::wordpress_template ? {
    ''      => "wordpress/wp-config.php", # Default value
    default => $::wordpress_template,
  }

  $options = $::wordpress_options ? {
    ''      => "",                      # Default value
    default => $::wordpress_options,
  }

  $absent = $::wordpress_absent ? {
    ''      => false,                   # Default value
    default => $::wordpress_absent,
  }



  ### General module variables that can have a site or per module default
  # They can be set at top scope level or in a ENC

  $monitor = $::wordpress_monitor ? {
    ''      => $::monitor ? {
      ''      => false,                # Default value
      default => $::monitor,
    },
    default => $::wordpress_monitor,
  }

  $monitor_tool = $::wordpress_monitor_tool ? {
    ''      => $::monitor_tool ? {
      ''      => "",                   # Default value
      default => $::monitor_tool,
    },
    default => $::wordpress_monitor_tool,
  }

  $monitor_target = $::wordpress_monitor_target ? {
    ''      => $::monitor_target ? {
      ''      => "$ipaddress",         # Default value
      default => $::monitor_target,
    },
    default => $::wordpress_monitor_target,
  }

  $puppi = $::wordpress_puppi ? {
    ''      => $::puppi ? {
      ''      => false,                # Default value
      default => $::puppi,
    },
    default => $::wordpress_puppi,
  }  

  $puppi_helper = $::wordpress_puppi_helper ? {
    ''      => $::puppi_helper ? {
      ''      => "standard",           # Default value
      default => $::puppi_helper,
    },
    default => $::wordpress_puppi_helper,
  }

  $debug = $::wordpress_debug ? {
    ''      => $::debug ? {
      ''      => false,                # Default value
      default => $::debug,
    },
    default => $::wordpress_debug,
  }

  $audit_only = $::wordpress_audit_only ? {
    ''      => $::audit_only ? {
      ''      => false,                # Default value
      default => $::audit_only,
    },
    default => $::wordpress_audit_only,
  }

}
