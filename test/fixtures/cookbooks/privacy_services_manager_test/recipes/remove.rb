privacy_services_manager 'accessibility' do
  service 'accessibility'
  user 'vagrant'
  applications ['/Applications/Safari.app']
  admin true
  action :remove
end
