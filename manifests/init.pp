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
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip. Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip. Used if install => "source" or "puppi"
#   By default is the distro's default DocumentRoot for Web or Application server
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check wordpress/manifests/params.pp before overriding the default settings
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check wordpress/manifests/params.pp before overriding the default settings
#
# [*url_check*]
#   An url, relevant to the wordpress application, to use for testing the correct deployment of wordpress.
#   Used is monitor is enabled.
# 
# [*url_pattern*]
#   A string that must exist in the defined url_check that confirms that the application is running correctly
#
#
# Standard class parameters - Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations 
#   If defined, wordpress class will automatically "include $my_class"
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, wordpress main config file will have the parameter: source => $source
#
# [*source_dir*]
#   If defined, the whole wordpress configuration directory content is retrieved recursively from
#   the specified source (parameter: source => $source_dir , recurse => true)
#
# [*source_dir_purge*]
#   If set to true all the existing configuration directory is overriden by the 
#   content retrived from source_dir. (source => $source_dir , recurse => true , purge => true) 
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, wordpress main config file will have: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*options*]
#   An hash of custom options that can be used in templates for arbitrary settings.
# 
# [*absent*] 
#   Set to 'true' to remove package(s) installed by module 
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for wordpress
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#
# 
# Default class params - As defined in wordpress::params.
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
  $my_class            = "",
  $source              = "",
  $source_dir          = "",
  $source_dir_purge    = false,
  $template            = "",
  $options             = "",
  $absent              = false,
  $monitor             = false,
  $monitor_tool        = "",
  $puppi               = false,
  $debug               = false,
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

  validate_bool($source_dir_purge, $absent , $monitor , $puppi , $debug)

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
    }
  }

  # Include custom class if $my_class is set
  if $wordpress::my_class {
    include $wordpress::my_class
  } 


  # Provide puppi data, if enabled ( puppi => true )
  if $wordpress::puppi == true { 
    $puppivars=get_class_args()
    file { "puppi_wordpress":
      path    => "${settings::vardir}/puppi/wordpress",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      ensure  => "${wordpress::manage_file}",
      require => Class["puppi"],         
      content => inline_template("<%= puppivars.to_yaml %>"),
    }
  }


  # Url check, if enabled ( monitor => true )
  if $wordpress::monitor == true and $wordpress::url_check != "" { 
    monitor::url { "wordpress_url":
      url     => "${wordpress::url_check}",
      pattern => "${wordpress::url_pattern}",
      port    => "${wordpress::port}",
      target  => "${fqdn}",
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
