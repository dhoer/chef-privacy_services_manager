actions :add, :remove, :enable, :disable
default_action :add

attribute :service, kind_of: String, required: true,
                    equal_to: %w(accessibility calendar contacts icloud location reminders)

attribute :applications, kind_of: [Array, NilClass], default: nil
attribute :user, kind_of: [String, NilClass], default: nil
attribute :language, kind_of: [String, NilClass], default: nil
attribute :log_dest, kind_of: [String, NilClass], default: nil

attribute :admin, kind_of: [TrueClass, FalseClass], default: false
attribute :forceroot, kind_of: [TrueClass, FalseClass], default: false
attribute :template, kind_of: [TrueClass, FalseClass], default: false
