name 'privacy_services_manager'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Configures Mac OS X Accessibility, Calendar, Contacts, iCloud, Location Services and Reminders'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.1'

chef_version '>= 11'

supports 'mac_os_x', '>= 10.8'

depends 'dmg', '~> 2.2'

source_url 'https://github.com/dhoer/chef-privacy_services_manager' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-privacy_services_manager/issues' if respond_to?(:issues_url)
