require 'spec_helper'

describe 'privacy_services_manager_test::disable' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'disables accessibility applications' do
    expect(chef_run).to disable_privacy_services_manager('disable accessibility')
      .with(applications: [
        '/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
        '/usr/libexec/sshd-keygen-wrapper'
      ])
  end

  it 'disables ardagent' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py --user vagrant --no-check-bin ' \
    'disable accessibility /System/Library/CoreServices/RemoteManagement/ARDAgent.app')
  end

  it 'disables ssh keygen wrapper' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py --user vagrant --no-check-bin ' \
    'disable accessibility /usr/libexec/sshd-keygen-wrapper')
  end
end
