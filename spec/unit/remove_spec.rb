require 'spec_helper'

describe 'privacy_services_manager_test::remove' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'removes accessibility' do
    expect(chef_run).to remove_privacy_services_manager('accessibility')
      .with(applications: ['com.apple.RemoteDesktopAgent'])
  end

  it 'executes tccutil' do
    expect(chef_run).to run_execute('sudo /usr/sbin/tccutil.py --remove com.apple.RemoteDesktopAgent')
  end
end
