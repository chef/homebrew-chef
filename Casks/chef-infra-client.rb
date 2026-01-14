cask "chef-infra-client" do
  version "18.9.4"

  # https://docs.brew.sh/Cask-Cookbook#handling-different-system-configurations
  on_arm do
    sha256 "d742ce87c2cbf1848128ae11de17590ce14c792f8c233067010fdb1c64dd82bb"
    # packages.chef.io was verified as official when first introduced to the cask
    url "https://packages.chef.io/files/current/chef/#{version}/mac_os_x/13/chef-#{version}-1.arm64.dmg"
    pkg "chef-#{version}-1.arm64.pkg"
  end

  # last Intel release
  on_intel do
    sha256 "79767d80fe9041de710c79c6076e8f7217ba248bd7f1e24aa876d762b88c363c"
    url "https://packages.chef.io/files/current/chef/18.8.54/mac_os_x/12/chef-18.8.54-1.x86_64.dmg"
    pkg "chef-18.8.54-1.x86_64.pkg"
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
