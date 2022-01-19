cask "chef-workstation" do
  arch = Hardware::CPU.intel? ? "x86_64" : "arm64"
  macos_version = Hardware::CPU.intel? ? "10.15" : "11"

  version "22.1.745"
  if Hardware::CPU.intel?
    sha256 "f6beaa7b00ecb062d541648e6562c9dba3c5380176c2cef612518b114cee712a"
  else
    sha256 "f6beaa7b00ecb062d541648e6562c9dba3c5380176c2cef612518b114cee712a"
  end

  url "https://packages.chef.io/files/stable/chef-workstation/#{version}/mac_os_x/#{macos_version}/chef-workstation-#{version}-1.#{arch}.dmg"
  name "Chef Workstation"
  desc "All-in-one installer for the tools you need to manage your Chef infrastructure"
  homepage "https://docs.chef.io/workstation/"

  livecheck do
    url "https://omnitruck.chef.io/stable/chef-workstation/metadata?p=mac_os_x&pv=#{macos_version}&m=#{arch}&v=latest"
    regex(/version\s*(\d+(?:\.\d+)+)/i)
  end

  depends_on macos: ">= :mojave"

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
