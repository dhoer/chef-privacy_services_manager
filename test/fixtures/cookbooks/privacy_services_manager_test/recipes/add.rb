privacy_services_manager 'contacts' do
  applications ['com.apple.RemoteDesktopAgent']
  user 'vagrant'
  log_dest '/tmp/tcc-out.log'
  admin true
  forceroot true
  language true
  template true
end
