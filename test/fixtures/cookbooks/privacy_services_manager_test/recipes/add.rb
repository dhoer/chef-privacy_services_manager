privacy_services_manager 'make rdagent accessible' do
  service 'accessibility'
  user 'vagrant'
  applications ['/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
      '/usr/libexec/sshd-keygen-wrapper']
  admin true
end
