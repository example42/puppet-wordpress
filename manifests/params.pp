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
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class wordpress::params {

  ### WebApp specific parameters
  $install = 'package'
  $install_source = 'http://wordpress.org/latest.zip'
  $install_dirname = 'wordpress'
  $install_precommand = ''
  $install_postcommand = ''
  $url_check = ''
  $url_pattern = 'wordpress'
  $web_server = 'apache'
  $web_server_template = ''
  $web_virtualhost = "$::fqdn"
  $db_type = 'mysql'
  $db_host = 'localhost'
  $db_name = 'wordpress'
  $db_user = 'wordpress'
  $db_password = fqdn_rand(100000000000)

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'wordpress',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '',
  }

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = ''
  $template = 'wordpress/wp-config.php'
  $options = ''
  $absent = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'phpapp'
  $debug = false
  $audit_only = false

}
