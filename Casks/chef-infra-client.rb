cask "chef-infra-client" do
  version "18.7.3"

  # https://docs.brew.sh/Cask-Cookbook#handling-different-system-configurations
  on_arm do
    sha256 "3a44f4e2614eca59897b3e736a7197bbc73c2ae3bfc8f333eb3dc0cb276fc23a"
    # packages.chef.io was verified as official when first introduced to the cask
    url "https://packages.chef.io/files/current/chef/18.7.3/mac_os_x/12/chef-#{version}-1.arm64.dmg"
    pkg "chef-#{version}-1.arm64.pkg"
  end

  on_intel do
    sha256 "f9579031792d7a97cffb4b0161310132777c8ea7af06cb6f7edade1cc5f6ce74"
    url "https://packages.chef.io/files/current/chef/18.7.3/mac_os_x/12/chef-#{version}-1.x86_64.dmg"
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
