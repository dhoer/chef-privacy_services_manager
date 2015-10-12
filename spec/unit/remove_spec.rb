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
    expect(chef_run).to remove_privacy_services_manager('remove accessibility')
      .with(applications: ['/Applications/Safari.app'])
  end

  it 'removes safari' do
    expect(chef_run).to run_execute('sudo /usr/local/bin/privacy_services_manager.py --user vagrant --no-check-bin'\
     ' remove accessibility /Applications/Safari.app')
  end
end
