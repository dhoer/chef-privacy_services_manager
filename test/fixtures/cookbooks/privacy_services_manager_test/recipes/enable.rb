privacy_services_manager 'enable accessibility' do
  service 'accessibility'
  user 'vagrant'
  applications ['/System/Library/CoreServices/RemoteManagement/ARDAgent.app']
  admin true
  action :enable
end
