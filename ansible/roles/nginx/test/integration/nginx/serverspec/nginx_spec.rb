require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
end

describe port(80) do
    it { should be_listening }
end
describe port(443) do
    it { should be_listening }
end
