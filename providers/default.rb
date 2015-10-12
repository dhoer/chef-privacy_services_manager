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
    privacy_services_manager_install
    privacy_services_manager_exec(action, resource)
  else
    log('Resource privacy_services_manager is not supported on this platform!') { level :warn }
  end
end

action :add do
  converge_by('privacy_services_manager add') do
    privacy_services_manager_service('add', new_resource)
  end
end

action :remove do
  converge_by('privacy_services_manager remove') do
    privacy_services_manager_service('remove', new_resource)
  end
end

action :enable do
  converge_by('privacy_services_manager enable') do
    privacy_services_manager_service('enable', new_resource)
  end
end

action :disable do
  converge_by('privacy_services_manager disable') do
    privacy_services_manager_service('disable', new_resource)
  end
end
