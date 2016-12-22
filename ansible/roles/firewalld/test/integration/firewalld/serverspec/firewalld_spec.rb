require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('firewalld') do
    it { should be_enabled }
    it { should be_running }
end

describe iptables do
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT') }
end
