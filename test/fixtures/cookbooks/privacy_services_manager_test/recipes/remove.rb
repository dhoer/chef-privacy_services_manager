privacy_services_manager 'remove accessibility' do
  service 'accessibility'
  user node['privacy_services_manager_test']['user']
  applications ['/Applications/Safari.app']
  no_check_bin true
  action :remove
end
