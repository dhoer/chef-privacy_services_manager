if defined?(ChefSpec)
  def add_privacy_services_manager(items)
    ChefSpec::Matchers::ResourceMatcher.new(:privacy_services_manager, :add, items)
  end

  def remove_privacy_services_manager(items)
    ChefSpec::Matchers::ResourceMatcher.new(:privacy_services_manager, :remove, items)
  end

  def enable_privacy_services_manager(items)
    ChefSpec::Matchers::ResourceMatcher.new(:privacy_services_manager, :enable, items)
  end

  def disable_privacy_services_manager(items)
    ChefSpec::Matchers::ResourceMatcher.new(:privacy_services_manager, :disable, items)
  end
end
