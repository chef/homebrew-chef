cask "chef-infra-client" do
  version "18.4.2"
  sha256 "89E64CE74223020FC695FBF6CFE86929BA1DAD52541C461A7B8623234EEE2010"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/chef/#{version}/mac_os_x/10.15/chef-#{version}-1.x86_64.dmg"
  name "Chef Infra Client"
  desc "open-source infrastructure as code (IAC) tool for reducing manual and repetitive tasks for Windows, Linux, Mac and *nix systems."
  homepage "https://community.chef.io/tools/chef-infra/"

  depends_on macos: ">= :catalina"

  pkg "chef-#{version}-1.x86_64.pkg"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command "/usr/bin/find",
      args: ["/usr/local/bin", "-lname", "/opt/chef/*", "-delete"],
      sudo: true
  end

  uninstall pkgutil: "com.getchef.pkg.chef",
            delete:  "/opt/chef/"
end
