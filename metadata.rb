name 'privacy_services_manager'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Configures Mac OS X Accessibility, Calendar, Contacts, iCloud, Location Services and Reminders'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

supports 'mac_os_x', '>= 10.8'

depends 'dmg', '~> 2.2'
