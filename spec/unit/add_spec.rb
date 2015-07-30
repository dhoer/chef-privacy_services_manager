require 'spec_helper'

describe 'privacy_services_manager_test::add' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'adds rdagent to accessibilty' do
    expect(chef_run).to add_privacy_services_manager('make rdagent accessible').with(
      service: 'accessibility',
        user: 'vagrant',
      applications: [
        '/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
        '/usr/libexec/sshd-keygen-wrapper',
        '/Applications/Safari.app'
      ],
      admin: true)
  end

  it 'executes privacy_services_manager' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py' \
      ' --user vagrant --log-dest /tmp/tcc-out.log --admin --forceroot --language --template' \
      ' add accessibility /System/Library/CoreServices/RemoteManagement/ARDAgent.app')
  end
end
