require 'serverspec'

# Required by serverspec
set :backend, :exec

user = ENV['TRAVIS_OS_NAME'] ? 'travis' : 'vagrant'

describe 'privacy_services_manager_test' do
  case os[:family]
  when 'darwin'
    describe file('/Library/Application Support/com.apple.TCC/TCC.db') do
      it { should be_file }
      it { should be_owned_by 'root' }
    end

    describe file("/Users/#{user}/Library/Application Support") do
      it { should be_directory }
      it { should be_owned_by user }
    end

    describe file("/Users/#{user}/Library/Application Support/com.apple.TCC") do
      it { should be_directory }
      it { should be_owned_by user }
    end

    describe file("/Users/#{user}/Library/Application Support/com.apple.TCC/TCC.db") do
      it { should be_file }
      it { should be_owned_by user }
    end
  end
end
