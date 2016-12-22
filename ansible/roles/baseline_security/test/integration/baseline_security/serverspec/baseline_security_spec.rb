require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file("/etc/profile.d/autologout.sh") do
    it { should exist }
    it { should be_file }
    it { should be_mode "755" }
    its(:content) { should match /TMOUT=300\nreadonly TMOUT\nexport TMOUT/ }
end

describe file("/etc/ssh/sshd_config") do
    it { should exist }
    it { should be_file }
    it { should be_mode "644" }
    its(:content) { should match /ClientAliveInterval 300/ }
end
