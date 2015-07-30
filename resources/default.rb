actions :add, :remove, :enable, :disable
default_action :add

attribute :service, kind_of: String, required: true,
                    equal_to: %w(accessibility calendar contacts icloud location reminders)

attribute :applications, kind_of: [Array, NilClass], privacy_services_manager_test: nil
attribute :user, kind_of: [String, NilClass], privacy_services_manager_test: nil
attribute :language, kind_of: [String, NilClass], privacy_services_manager_test: nil
attribute :log_dest, kind_of: [String, NilClass], privacy_services_manager_test: nil

attribute :admin, kind_of: [TrueClass, FalseClass], privacy_services_manager_test: false
attribute :forceroot, kind_of: [TrueClass, FalseClass], privacy_services_manager_test: false
attribute :template, kind_of: [TrueClass, FalseClass], privacy_services_manager_test: false
