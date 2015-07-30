privacy_services_manager 'accessibility' do
  service 'accessibility'
  user 'vagrant'
  applications [
    '/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
    '/usr/libexec/sshd-keygen-wrapper'
  ]
  admin true
  action :disable
end
