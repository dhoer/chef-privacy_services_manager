privacy_services_manager 'disable accessibility' do
  service 'accessibility'
  user 'vagrant'
  applications [
    '/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
    '/usr/libexec/sshd-keygen-wrapper'
  ]
  admin true
  action :disable
end
