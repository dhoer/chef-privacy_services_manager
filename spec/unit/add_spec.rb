require 'spec_helper'

describe 'privacy_services_manager_test::add' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'adds accessibilty applications' do
    expect(chef_run).to add_privacy_services_manager('add accessibility').with(
      service: 'accessibility',
      user: 'vagrant',
      applications: [
        '/System/Library/CoreServices/RemoteManagement/ARDAgent.app',
        '/usr/libexec/sshd-keygen-wrapper',
        '/Applications/Safari.app'
      ],
      admin: true)
  end

  it 'adds ardagent' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py' \
      ' --user vagrant --admin add accessibility /System/Library/CoreServices/RemoteManagement/ARDAgent.app')
  end

  it 'adds ssh keygen wrapper' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py' \
      ' --user vagrant --admin add accessibility /usr/libexec/sshd-keygen-wrapper')
  end
  it 'adds safari' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py' \
      ' --user vagrant --admin add accessibility /Applications/Safari.app')
  end
end
