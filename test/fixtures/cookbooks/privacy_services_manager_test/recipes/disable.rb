privacy_services_manager 'disable accessibility' do
  service 'accessibility'
  user node['privacy_services_manager_test']['user']
  applications [
    '/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
    '/usr/libexec/sshd-keygen-wrapper'
  ]
  no_check_bin true
  action :disable
end
