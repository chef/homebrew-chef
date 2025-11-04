cask "chef-infra-client" do
  version "18.8.54"

  # https://docs.brew.sh/Cask-Cookbook#handling-different-system-configurations
  on_arm do
    sha256 "970f44abd0e9c080d649511655250322b82ab491be19e9101135319f2516f472"
    # packages.chef.io was verified as official when first introduced to the cask
    url "https://packages.chef.io/files/current/chef/#{version}/mac_os_x/12/chef-#{version}-1.arm64.dmg"
    pkg "chef-#{version}-1.arm64.pkg"
  end

  on_intel do
    sha256 "79767d80fe9041de710c79c6076e8f7217ba248bd7f1e24aa876d762b88c363c"
    url "https://packages.chef.io/files/current/chef/#{version}/mac_os_x/12/chef-#{version}-1.x86_64.dmg"
    pkg "chef-#{version}-1.x86_64.pkg"
  end

  name "Chef Infra Client"
  desc "open-source infrastructure as code (IAC) tool for reducing manual and repetitive tasks for Windows, Linux, Mac and *nix systems."
  homepage "https://community.chef.io/tools/chef-infra/"

  depends_on macos: ">= :monterey"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command "/usr/bin/find",
      args: ["/usr/local/bin", "-lname", "/opt/chef/*", "-delete"],
      sudo: true
  end

  uninstall pkgutil: "com.getchef.pkg.chef",
    delete:  "/opt/chef/"
end
