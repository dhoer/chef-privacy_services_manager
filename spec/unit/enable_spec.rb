require 'spec_helper'

describe 'privacy_services_manager_test::enable' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'enables accessibility applications' do
    expect(chef_run).to enable_privacy_services_manager('enable accessibility')
      .with(applications: ['/System/Library/CoreServices/RemoteManagement/ARDAgent.app'])
  end

  it 'enables ardagent' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py --user vagrant --admin' \
    ' enable accessibility /System/Library/CoreServices/RemoteManagement/ARDAgent.app')
  end
end
