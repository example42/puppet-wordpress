# Class: wordpress
#
# This is the main wordpress class
#
#
# == Parameters
#
# Standard class parameters - Define wordpress web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs wordpress using the OS common packages
#     - source  : Installs wordpress downloading and extracting a specific tarball or zip file
#     - puppi   : Installs wordpress tarball or file via Puppi, creating the "puppi deploy wordpress" command
#   Can be defined also by the (top scope) variable $wordpress_install
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip. Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#   Can be defined also by the (top scope) variable $wordpress_install_source
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip. Used if install => "source" or "puppi"
#   By default is the distro's default DocumentRoot for Web or Application server
#   Can be defined also by the (top scope) variable $wordpress_install_destination
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check wordpress/manifests/params.pp before overriding the default settings
#   Can be defined also by the (top scope) variable $wordpress_install_precommand
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check wordpress/manifests/params.pp before overriding the default settings
#   Can be defined also by the (top scope) variable $wordpress_install_postcommand
#
# [*url_check*]
#   An url, relevant to the wordpress application, to use for testing the correct deployment of wordpress.
#   Used is monitor is enabled.
#   Can be defined also by the (top scope) variable $wordpress_url_check
# 
# [*url_pattern*]
#   A string that must exist in the defined url_check that confirms that the application is running correctly
#   Can be defined also by the (top scope) variable $wordpress_url_pattern
#
# [*web_server*]
#   The type of web server you want to preconfigure. (Possible values: apache, lighttpd, nginx) 
#   Can be defined also by the (top scope) variable $wordpress_web_server
#
# [*web_server_template*]
#   The path of the template to use for web server configuration
#   Can be defined also by the (top scope) variable $wordpress_web_server_template
#
# [*web_virtualhost*]
#   An optional virtualhost name to map to the wordpress application
#   Can be defined also by the (top scope) variable $wordpress_web_virtualhost
#
# [*db_type*]
#   Database type to use. Default: mysql
#   Can be defined also by the (top scope) variable $wordpress_db_type
#
# [*db_name*]
#   Name of the database to create
#   Can be defined also by the (top scope) variable $wordpress_db_name
#
# [*db_host*]
#   Your database server hostname. Default: localhost
#   If you define an external db server and want to configure it automatically, you need to have StoredConfigs activated.
#   Can be defined also by the (top scope) variable $wordpress_db_host
#
# [*db_user*]
#   The user wordpress uses to connect to the database
#   Can be defined also by the (top scope) variable $wordpress_db_user
#
# [*db_password*]
#   The password used by db_user. Default is a random value (that doesn't change in different Puppet runs)
#   Can be defined also by the (top scope) variable $wordpress_db_password
#
#
# Standard class parameters - Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations 
#   If defined, wordpress class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $wordpress_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, wordpress main config file will have the parameter: source => $source
#   Can be defined also by the (top scope) variable $wordpress_source
#
# [*source_dir*]
#   If defined, the whole wordpress configuration directory content is retrieved recursively from
#   the specified source (parameter: source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $wordpress_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false)  the existing configuration directory is mirrored with the 
#   content retrieved from source_dir. (source => $source_dir , recurse => true , purge => true) 
#   Can be defined also by the (top scope) variable $wordpress_source_dir_purge
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, wordpress main config file will have: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $wordpress_template
#
# [*options*]
#   An hash of custom options that can be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $wordpress_options
# 
# [*absent*] 
#   Set to 'true' to remove package(s) installed by module 
#   Can be defined also by the (top scope) variable $wordpress_absent
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $wordpress_monitor and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for wordpress
#   Can be defined also by the (top scope) variables $wordpress_monitor_tool and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools. Default is the fact $ip_address
#   Can be defined also by the (top scope) variables $wordpress_monitor_target and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $wordpress_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module is specified in params.pp
#   and is generally a good choice. You can customize the output of puppi commands for this module
#   using a different puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $wordpress_puppi_helper and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $wordpress_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files and want to audit the
#   difference between existing files and the ones that Puppet would provide
#   Can be defined also by the (top scope) variables $wordpress_audit_only and $audit_only
# 
# Note that these variables are mostly defined and used in the module itself, overriding the default
# values might not affected all the involved components (ie: packages layout)
# Set and override them only if you know what you're doing.
#
# [*package*]
#   The name of wordpress package 
# 
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
#
# == Examples
# 
# See README
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class wordpress (
  $install             = $wordpress::params::install,
  $install_source      = $wordpress::params::install_source,
  $install_destination = $wordpress::params::install_destination,
  $install_precommand  = $wordpress::params::install_precommand,
  $install_postcommand = $wordpress::params::install_postcommand,
  $url_check           = $wordpress::params::url_check,
  $url_pattern         = $wordpress::params::url_pattern,
  $web_server          = $wordpress::params::web_server,
  $web_server_template = $wordpress::params::web_server_template,
  $web_virtualhost     = $wordpress::params::web_virtualhost,
  $db_type             = $wordpress::params::db_type,
  $db_name             = $wordpress::params::db_name,
  $db_host             = $wordpress::params::db_host,
  $db_user             = $wordpress::params::db_user,
  $db_password         = $wordpress::params::db_password,
  $my_class            = $wordpress::params::my_class,
  $source              = $wordpress::params::source,
  $source_dir          = $wordpress::params::source_dir,
  $source_dir_purge    = $wordpress::params::source_dir_purge,
  $template            = $wordpress::params::template,
  $options             = $wordpress::params::options,
  $absent              = $wordpress::params::absent,
  $monitor             = $wordpress::params::monitor,
  $monitor_tool        = $wordpress::params::monitor_tool,
  $monitor_target      = $wordpress::params::monitor_target,
  $puppi               = $wordpress::params::puppi,
  $puppi_helper        = $wordpress::params::puppi_helper,
  $firewall            = $wordpress::params::firewall,
  $firewall_tool       = $wordpress::params::firewall_tool,
  $firewall_src        = $wordpress::params::firewall_src, 
  $firewall_dst        = $wordpress::params::firewall_dst,
  $debug               = $wordpress::params::debug,
  $audit_only          = $wordpress::params::audit_only,
  $package             = $wordpress::params::package,   
  $config_dir          = $wordpress::params::config_dir,
  $config_file         = $wordpress::params::config_file,
  $config_file_mode    = $wordpress::params::config_file_mode,
  $config_file_owner   = $wordpress::params::config_file_owner,
  $config_file_group   = $wordpress::params::config_file_group,
  $data_dir            = $wordpress::params::data_dir, 
  $log_dir             = $wordpress::params::log_dir, 
  $log_file            = $wordpress::params::log_file 
  ) inherits wordpress::params {

##  validate_bool($source_dir_purge , $absent , $monitor , $firewall , $debug, $audit_only)

  # Calculations of some variables used in the module
  $manage_package = $wordpress::absent ? {
    true  => "absent",
    false => "present",
  }
 
  $manage_file = $wordpress::absent ? {
    true    => "absent",
    default => "present",
  }

  $manage_monitor = $wordpress::absent ? {
    true  => false ,
    default => $wordpress::disable ? {
      true    => false,
      default => true,
    }
  }

  $manage_audit = $wordpress::audit_only ? {
    true  => "all",
    false => undef,
  }

  $manage_file_replace = $wordpress::audit_only ? {
    true  => false,
    false => true,
  }

  # Installation is managed in dedicated class
  require wordpress::install

  file { "wordpress.conf":
    path    => "${wordpress::config_file}",
    mode    => "${wordpress::config_file_mode}",
    owner   => "${wordpress::config_file_owner}",
    group   => "${wordpress::config_file_group}",
    ensure  => "${wordpress::manage_file}",
    require => Class["wordpress::install"],
    source  => $source ? {
      ''      => undef,
      default => $source,
    },
    content => $template ? {
      ''      => undef,
      default => template("$template"),
    },
    replace => "${wordpress::manage_file_replace}",
    audit   => $wordpress::manage_audit,
  }

  # Whole wordpress configuration directory can be recursively overriden
  if $wordpress::source_dir {
    file { "wordpress.dir":
      path    => "${wordpress::config_dir}",
      ensure  => directory,
      require => Class["wordpress::install"],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => "${wordpress::manage_file_replace}",
      audit   => $wordpress::manage_audit,
    }
  }

  # Include custom class if $my_class is set
  if $wordpress::my_class {
    include $wordpress::my_class
  } 

  # Include web server configuration if requested
  if $wordpress::web_server {
    stdlib42::webconfig { "$wordpress::web_virtualhost":
      webserver          => $wordpress::web_server,
      webserver_template => $wordpress::web_server_template,
      virtualhost        => $wordpress::web_virtualhost,
      document_root      => $wordpress::destination_dir,
      access_log         => "$wordpress::log_dir/$wordpress::web_virtualhost-access.log",
      error_log          => "$wordpress::log_dir/$wordpress::web_virtualhost-error.log",
    }
  } 

  # Include database configuration, if db_type set 
  if $wordpress::db_type == "mysql" {
    include wordpress::mysql
  } 

  # Provide puppi data, if enabled ( puppi => true )
  if any2bool($wordpress::puppi) == true { 
    $classvars=get_class_args()
    puppi::ze { 'wordpress':
      ensure    => $wordpress::manage_file,
      variables => $classvars,
      helper    => $wordpress::puppi_helper,
    }
  }


  # Url check, if enabled ( monitor => true )
  if $wordpress::monitor == true and $wordpress::url_check != "" { 
    monitor::url { "wordpress_url":
      url     => "${wordpress::url_check}",
      pattern => "${wordpress::url_pattern}",
      port    => "${wordpress::port}",
      target  => "${wordpress::params::monitor_target}",
      tool    => "${wordpress::monitor_tool}",
      enable  => $wordpress::manage_monitor,
    }
  }


  # Include debug class is debugging is enabled 
  if $wordpress::debug == true {
    file { "debug_wordpress":
      path    => "${settings::vardir}/debug-wordpress",
      mode    => "0640",
      owner   => "root",
      group   => "root",
      ensure  => "$wordpress::manage_file",
      content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>"),
    }
  }

}
