require 'spec_helper'

describe 'privacy_services_manager_test::add' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04',
      step_into: ['privacy_services_manager']
    ).converge(described_recipe)
  end

  it 'calls accessibility' do
    expect(chef_run).to add_privacy_services_manager('add accessibility')
  end

  it 'logs warning' do
    expect(chef_run).to write_log('Resource privacy_services_manager is not supported on this platform!')
  end
end
