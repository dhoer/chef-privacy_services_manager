def whyrun_supported?
  true
end

use_inline_resources

def privacy_services_manager_install
  recipe_eval do
    run_context.include_recipe 'privacy_services_manager::default'
  end
end

# rubocop:disable all
def privacy_services_manager_flags(resource)
  cmd = []
  cmd << "--user #{resource.user}" if resource.user
  cmd << "--language #{resource.language}" if resource.language
  cmd << "--log-dest #{resource.log_dest}" if resource.log_dest
  cmd << '--no-check-bin' if resource.admin || resource.no_check_bin
  cmd << '--forceroot' if resource.forceroot
  cmd << '--template' if resource.template
  cmd.join(' ')
end

def hack_for_xcode8x
  Chef::Log.warn("**********Platform version: #{node['platform_version']}")
  return unless node['platform_version'].include?('10.12')

  execute 'hack_for_xcode8x' do
    command <<-EOF
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.locationd.plist
sudo /usr/libexec/PlistBuddy -c \
"Set :com.apple.locationd.bundle-/System/Library/PrivateFrameworks/AssistantServices.framework:Authorized true" \
/var/db/locationd/clients.plist
sudo launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist
    EOF
  end
end

# rubocop:enable all

def privacy_services_manager_cmd(action, resource)
  flags = privacy_services_manager_flags(resource)
  "sudo /usr/local/bin/privacy_services_manager.py #{flags} #{action} #{resource.service}"
end

def privacy_services_manager_exec(action, resource)
  cmd = privacy_services_manager_cmd(action, resource)
  apps = resource.applications
  if apps
    apps.each do |app|
      execute "#{cmd} #{app}"
    end
  else
    execute cmd
  end
end

def privacy_services_manager_service(action, resource)
  if platform_family?('mac_os_x')
    hack_for_xcode8x
    privacy_services_manager_install
    privacy_services_manager_exec(action, resource)
  else
    Chef::Log.warn('Resource privacy_services_manager is not supported on this platform!')
  end
end

action :add do
  privacy_services_manager_service('add', new_resource)
end

action :remove do
  privacy_services_manager_service('remove', new_resource)
end

action :enable do
  privacy_services_manager_service('enable', new_resource)
end

action :disable do
  privacy_services_manager_service('disable', new_resource)
end
