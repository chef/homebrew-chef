cask "chef-workstation" do
  arch = Hardware::CPU.intel? ? "x86_64" : "arm64"
  macos_version = Hardware::CPU.intel? ? "10.15" : "11"

  version "22.6.973"
  if Hardware::CPU.intel?
    sha256 "ee255856f8a8422e59f8397ae0ad07122822ac39c583f5e1eeee1f075a38a916"
  else
    sha256 "ee255856f8a8422e59f8397ae0ad07122822ac39c583f5e1eeee1f075a38a916"
  end

  url "https://packages.chef.io/files/stable/chef-workstation/#{version}/mac_os_x/#{macos_version}/chef-workstation-#{version}-1.#{arch}.dmg"
  name "Chef Workstation"
  desc "all-in-one installer for the tools you need to manage your Chef infrastructure"
  homepage "https://community.chef.io/tools/chef-workstation"

  livecheck do
    url "https://omnitruck.chef.io/stable/chef-workstation/metadata?p=mac_os_x&pv=#{macos_version}&m=#{arch}&v=latest"
    regex(/version\s*(\d+(?:\.\d+)+)/i)
  end

  depends_on macos: ">= :catalina"

  pkg "chef-workstation-#{version}-1.#{arch}.pkg"

  uninstall quit:      "sh.chef.chef-workstation",
            pkgutil:   "com.getchef.pkg.chef-workstation",
            launchctl: "io.chef.chef-workstation.app",
            script:    {
              executable: "/opt/chef-workstation/bin/uninstall_chef_workstation",
              sudo:       true,
            }

  zap trash: "~/.chef-workstation/"
end
