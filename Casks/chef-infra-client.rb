cask "chef-infra-client" do
  version "18.7.6"

  # https://docs.brew.sh/Cask-Cookbook#handling-different-system-configurations
  on_arm do
    sha256 "c76e9f3f3c5952017e6b19083d8e11b8b9d8684cacfa7b0923ed070b5ffc34f3"
    # packages.chef.io was verified as official when first introduced to the cask
    url "https://packages.chef.io/files/current/chef/18.7.6/mac_os_x/12/chef-#{version}-1.arm64.dmg"
    pkg "chef-#{version}-1.arm64.pkg"
  end

  on_intel do
    sha256 "30eead5f4d8606381cb57efe35f75f245623bb82a824a01314d9704bea591791"
    url "https://packages.chef.io/files/current/chef/18.7.6/mac_os_x/12/chef-#{version}-1.x86_64.dmg"
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
