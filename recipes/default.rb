if platform_family?('mac_os_x')
  include_recipe 'privacy_services_manager::management_tools'
  version = node['privacy_services_manager']['version']
  dmg_package "Privacy Services Management [#{version}]" do
    source 'https://github.com/univ-of-utah-marriott-library-apple' \
      "/privacy_services_manager/releases/download/#{version}/Privacy.Services.Management.#{version}.dmg"
    checksum node['privacy_services_manager']['checksum']
    type 'pkg'
    action :install
    not_if { ::File.exist?('/usr/local/bin/privacy_services_manager.py') }
  end
else
  log('Privacy Services Management cannot be installed on this platform using this cookbook!') { level :warn }
end
