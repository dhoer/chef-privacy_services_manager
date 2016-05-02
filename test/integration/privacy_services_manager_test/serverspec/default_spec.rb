require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'privacy_services_manager_test' do
  case os[:family]
  when 'darwin'
    describe file('/Library/Application Support/com.apple.TCC/TCC.db') do
      it { should be_file }
      it { should be_owned_by 'root' }
    end

    describe file("/Users/#{ENV['USER']}/Library/Application Support") do
      it { should be_directory }
      it { should be_owned_by ENV['USER'] }
    end

    describe file("/Users/#{ENV['USER']}/Library/Application Support/com.apple.TCC") do
      it { should be_directory }
      it { should be_owned_by ENV['USER'] }
    end

    describe file("/Users/#{ENV['USER']}/Library/Application Support/com.apple.TCC/TCC.db") do
      it { should be_file }
      it { should be_owned_by ENV['USER'] }
    end
  end
end
