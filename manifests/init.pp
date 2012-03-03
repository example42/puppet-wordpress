# = Class: wordpress
#
# This is the main wordpress class
#
#
# == Parameters
#
# WebApp Specific params
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs wordpress using the OS common packages
#     - source  : Installs wordpress downloading and extracting a specific
#                 tarball or zip file
#     - puppi   : Installs wordpress tarball or file via Puppi, creating the
#                 "puppi deploy wordpress" command
#   Can be defined also by the variable $wordpress_install
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#   Can be defined also by the variable $wordpress_install_source
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip.
#   Used if install => "source" or "puppi"
#   By default is the distro's default DocumentRoot for Web server
#   Can be defined also by the variable $wordpress_install_destination
#
# [*install_dirname*]
#   Name of the directory created by the source tarball/zip
#   Default is based on the official sources. You hardly need to override it
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check wordpress/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $wordpress_install_precommand
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check wordpress/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $wordpress_install_postcommand
#
# [*url_check*]
#   An url, relevant to the wordpress application, to use for testing the
#   correct deployment of wordpress. Used is monitor is enabled.
#   Can be defined also by the variable $wordpress_url_check
#
# [*url_pattern*]
#   A string or regexp that must exist in the defined url_check that confirms
#   that the application is running correctly
#   Can be defined also by the variable $wordpress_url_pattern
#
# [*web_server*]
#   The type of web server you want to preconfigure.
#   Can be defined also by the variable $wordpress_web_server
#
# [*web_server_template*]
#   The path of the template to use for web server configuration
#   Can be defined also by the variable $wordpress_web_server_template
#
# [*web_virtualhost*]
#   An optional virtualhost name to map to the wordpress application
#   Can be defined also by the variable $wordpress_web_virtualhost
#
# [*db_type*]
#   Database type to use. Default: mysql
#   Can be defined also by the variable $wordpress_db_type
#
# [*db_name*]
#   Name of the database to create
#   Can be defined also by the variable $wordpress_db_name
#
# [*db_host*]
#   Your database server hostname. Default: localhost
#   If you define an external db server and want to configure it
#   automatically, you need to have StoredConfigs activated.
#   Can be defined also by the variable $wordpress_db_host
#
# [*db_user*]
#   The user wordpress uses to connect to the database
#   Can be defined also by the variable $wordpress_db_user
#
# [*db_password*]
#   The password used by db_user. Default is a random value
#   Can be defined also by the variable $wordpress_db_password
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, wordpress class will automatically "include $my_class"
#   Can be defined also by the variable $wordpress_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, wordpress main config file will have the param:
#   source => $source
#   Can be defined also by the variable $wordpress_source
#
# [*source_dir*]
#   If defined, the whole wordpress configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the variable $wordpress_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the variable $wordpress_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, wordpress main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the variable $wordpress_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the variable $wordpress_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the variable $wordpress_absent
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the variables $wordpress_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for wordpress checks
#   Can be defined also by the variables $wordpress_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the variables $wordpress_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the variables $wordpress_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the variables $wordpress_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the variables $wordpress_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the variables $wordpress_audit_only
#   and $audit_only
#
# Default class params - As defined in wordpress::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
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
#   Path of application files
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include wordpress"
# - Call wordpress as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class wordpress (
  $install             = params_lookup( 'install' ),
  $install_source      = params_lookup( 'install_source' ),
  $install_destination = params_lookup( 'install_destination' ),
  $install_dirname     = params_lookup( 'install_dirname' ),
  $install_precommand  = params_lookup( 'install_precommand' ),
  $install_postcommand = params_lookup( 'install_postcommand' ),
  $url_check           = params_lookup( 'url_check' ),
  $url_pattern         = params_lookup( 'url_pattern' ),
  $web_server          = params_lookup( 'web_server' ),
  $web_server_template = params_lookup( 'web_server_template' ),
  $web_virtualhost     = params_lookup( 'web_virtualhost' ),
  $db_type             = params_lookup( 'db_type' ),
  $db_name             = params_lookup( 'db_name' ),
  $db_host             = params_lookup( 'db_host' ),
  $db_user             = params_lookup( 'db_user' ),
  $db_password         = params_lookup( 'db_password' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $options             = params_lookup( 'options' ),
  $absent              = params_lookup( 'absent' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' )
  ) inherits wordpress::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_absent=any2bool($absent)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $wordpress::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_file = $wordpress::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $wordpress::bool_absent == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $wordpress::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $wordpress::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $wordpress::source ? {
    ''        => undef,
    default   => $wordpress::source,
  }

  $manage_file_content = $wordpress::template ? {
    ''        => undef,
    default   => template($wordpress::template),
  }

  ### Calculations of variables whoe value depends on different params
  $real_install_destination = $wordpress::install_destination ? { 
    ''      => $wordpress::webserver ? {
      default => $::operatingsystem ? {
        /(?i:Debian|Ubuntu|Mint)/ => '/var/www',
        /(?i:Suse|OpenSuse)/      => '/srv/www',
        default                   => '/var/www/html',
      },
    },
    default => $wordpress::install_destination,
  }

  $real_config_file = $wordpress::config_file ? {
    ''      => $wordpress::install ? {
      package => $::operatingsystem ? {
        default => '/etc/wordpress/wp-config.php',
      },
      default => "${wordpress::real_install_destination}/${wordpress::install_dirname}/wp-config.php",
    },
    default => $wordpress::config_file,
  }

  $real_config_dir = $wordpress::config_dir ? {
    ''      => $wordpress::install ? {
      package => $::operatingsystem ? {
        default => '/etc/wordpress/',
      },
      default => "${wordpress::real_install_destination}/${wordpress::install_dirname}/",
    },
    default => $wordpress::config_file,
  }

  $real_data_dir = $wordpress::data_dir ? {
    ''      => $wordpress::install ? {
      package => '/usr/share/wordpress',
      default => "${wordpress::real_install_destination}/${wordpress::install_dirname}",
    },
    default => $wordpress::data_dir,
  }

  $real_web_server_template = $wordpress::web_server_template ? {
    ''      => $wordpress::web_server ? {
      apache  =>  'wordpress/apache/virtualhost.conf.erb',
      nginx   =>  'wordpress/nginx/virtualhost.conf.erb',
    },
    default => $wordpress::web_server_template,
  }

  ### Managed resources
  # Installation is managed in dedicated class
  require wordpress::install

  file { 'wordpress.conf':
    ensure  => $wordpress::manage_file,
    path    => $wordpress::real_config_file,
    mode    => $wordpress::config_file_mode,
    owner   => $wordpress::config_file_owner,
    group   => $wordpress::config_file_group,
    require => Class['wordpress::install'],
    source  => $wordpress::manage_file_source,
    content => $wordpress::manage_file_content,
    replace => $wordpress::manage_file_replace,
    audit   => $wordpress::manage_audit,
  }

  # The whole wordpress configuration directory can be recursively overriden
  if $wordpress::source_dir {
    file { 'wordpress.dir':
      ensure  => directory,
      path    => $wordpress::real_config_dir,
      require => Class['wordpress::install'],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $wordpress::manage_file_replace,
      audit   => $wordpress::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $wordpress::my_class {
    include $wordpress::my_class
  }

  # Include web server configuration if requested
  case $wordpress::web_server {
    apache: { include wordpress::apache }
    nginx: { include wordpress::nginx }
    default: { }
  }

  # Include database configuration, if db_type set
  case $wordpress::db_type {
    mysql: { include wordpress::mysql }
    default: { }
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $wordpress::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'wordpress':
      ensure    => $wordpress::manage_file,
      variables => $classvars,
      helper    => $wordpress::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $wordpress::bool_monitor == true and $wordpress::url_check != '' {
    monitor::url { 'wordpress_url':
      url     => $wordpress::url_check,
      pattern => $wordpress::url_pattern,
      port    => $wordpress::port,
      target  => $wordpress::params::monitor_target,
      tool    => $wordpress::monitor_tool,
      enable  => $wordpress::manage_monitor,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $wordpress::bool_debug == true {
    file { 'debug_wordpress':
      ensure  => $wordpress::manage_file,
      path    => "${settings::vardir}/debug-wordpress",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }
}
