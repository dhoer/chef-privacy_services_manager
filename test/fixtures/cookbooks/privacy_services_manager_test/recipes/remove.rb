privacy_services_manager 'remove accessibility' do
  service 'accessibility'
  user 'vagrant'
  applications ['/Applications/Safari.app']
  no_check_bin true
  action :remove
end
