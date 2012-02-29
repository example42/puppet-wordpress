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
# This class is not intended to be used directly.
# It's automatically included by wordpress
#
class wordpress::install inherits wordpress {

  case $wordpress::install {

    package: {
      package { 'wordpress':
        ensure => $wordpress::manage_package,
        name   => $wordpress::package,
      }
    }

    source: {
      puppi::netinstall { 'netinstall_wordpress':
        url                 => $wordpress::install_source,
        destination_dir     => $wordpress::real_install_destination,
        extracted_dir       => $wordpress::install_dirname,
        preextract_command  => $wordpress::install_precommand,
        postextract_command => $wordpress::install_postcommand,
      }
    }

    puppi: {
      puppi::project::archive { 'wordpress':
        source                   => $wordpress::install_source,
        deploy_root              => $wordpress::real_install_destination,
        predeploy_customcommand  => $wordpress::install_precommand,
        postdeploy_customcommand => $wordpress::install_postcommand,
        report_email             => 'root',
        auto_deploy              => true,
        enable                   => true,
      }
    }

    default: { }

  }

}
