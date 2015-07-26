require 'spec_helper'

describe 'privacy_services_manager::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10'
    ).converge(described_recipe)
  end

  it 'installs privacy_services_manager' do
    expect(chef_run).to install_dmg_package('Privacy Services Management [1.6.6]')
  end
end
