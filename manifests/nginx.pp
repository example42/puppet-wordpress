# Class: wordpress::nginx
#
# This class configures nginx for wordpress installation
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by wordpress
#
class wordpress::nginx inherits wordpress {

  nginx::resource::vhost { $wordpress::web_virtualhost :
#    template  => $wordpress::real_web_server_template,
    www_root  => $wordpress::real_data_dir,
  }

}
