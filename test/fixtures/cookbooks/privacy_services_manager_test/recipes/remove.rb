privacy_services_manager 'remove accessibility' do
  service 'accessibility'
  user 'vagrant'
  applications ['/Applications/Safari.app']
  admin true
  action :remove
end
