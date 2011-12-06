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
  $install = "package"

  # Install source from the upstream provider is updated to module's last update time
  # You may need to change this: use the "install_source" parameter of the wordpress class
  $install_source = "http://wordpress.org/latest.zip"
 
  $install_destination = $operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => "/var/www",
    /(?i:Suse|OpenSuse)/      => "/srv/www",
    default                   => "/var/www/html",
  }

  $install_precommand  = ""

  $install_postcommand = ""

  $url_check           = ""

  $url_pattern         = "OK"

  $package = $operatingsystem ? {
    default => "wordpress",
  }

  $config_dir = $operatingsystem ? {
    default => "/etc/wordpress",
  }

  $config_file = $operatingsystem ? {
    default => "/etc/wordpress/wp-config.php",
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

  $data_dir = $operatingsystem ? {
    default => "/usr/share/wordpress",
  }

  $log_dir = $operatingsystem ? {
    default => "/var/log",
  }

  $log_file = $operatingsystem ? {
    default => "/var/log/wordpress.log",
  }

}
