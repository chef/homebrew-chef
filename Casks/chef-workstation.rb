cask "chef-workstation" do
  arch = Hardware::CPU.intel? ? "x86_64" : "arm64"
  macos_version = Hardware::CPU.intel? ? "10.15" : "11"

  version "22.2.807"
  if Hardware::CPU.intel?
    sha256 "f4b85ef391316864099b1a18207cd4fc510d8c54fc3fdcd1c6299ae3c4e83757"
  else
    sha256 "aab6b4f5e5ceb2f196f67da8dbd317092e648e900394de3761c39f7199eafcd6"
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
