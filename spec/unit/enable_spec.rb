require 'spec_helper'

describe 'privacy_services_manager_test::enable' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'enables accessibility' do
    expect(chef_run).to enable_privacy_services_manager('accessibility')
      .with(applications: ['com.apple.RemoteDesktopAgent'])
  end

  it 'executes tccutil' do
    expect(chef_run).to run_execute('sudo /usr/sbin/tccutil.py --enable com.apple.RemoteDesktopAgent')
  end
end
