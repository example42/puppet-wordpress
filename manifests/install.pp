# Class: wordpress::install
#
# This class installs wordpress
#
# == Variables
# 
# Refer to wordpress class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It's automatically included by wordpress
#
class wordpress::install inherits wordpress {

  case $wordpress::install {

    package: {
      package { "wordpress":
        name   => "${wordpress::package}",
        ensure => "${wordpress::manage_package}",
      }
    }

    source: {
      netinstall { "netinstall_wordpress":
        url                 => "${wordpress::install_source}",
        destination_dir     => "${wordpress::install_destination}",
        preextract_command  => "${wordpress::install_precommand}",
        postextract_command => "${wordpress::install_postcommand}",
      }
    }

    puppi: {
      puppi::project::archive { "wordpress":
        source                   => "${wordpress::install_source}",
        deploy_root              => "${wordpress::install_destination}",
        predeploy_customcommand  => "${wordpress::install_precommand}",
        postdeploy_customcommand => "${wordpress::install_postcommand}",
        report_email             => "root",
        auto_deploy              => true,
        enable                   => true,
      }
    }

  }

}
