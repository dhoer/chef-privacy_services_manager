# TODO: Move this installer to its own cookbook
if platform_family?('mac_os_x')
  version = node['privacy_services_manager']['management_tools']['version']
  dmg_package "Management_Tools_#{version}" do
    source 'https://github.com/univ-of-utah-marriott-library-apple' \
      "/management_tools/releases/download/#{version}/Management_Tools_#{version}.dmg"
    checksum node['privacy_services_manager']['management_tools']['checksum']
    type 'pkg'
    action :install
    not_if { ::File.exist?('/usr/local/bin/app_lookup.py') }
  end
else
  Chef::Log.warn('Management Tools cannot be installed on this platform using this cookbook!')
end
