# Class: wordpress::apache
#
# This class configures apache for wordpress installation
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by wordpress
#
class wordpress::apache inherits wordpress {

  apache::vhost { $wordpress::web_virtualhost :
    template => $wordpress::web_server_template,
    docroot  => $wordpress::real_install_destination,
    port     => '80',
  }

}
