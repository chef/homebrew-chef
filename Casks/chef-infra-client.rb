cask "chef-infra-client" do
  version "16.7.61"
  sha256 "29ff523fde6db9a2e1c9296ef725f5202e8124ddaab30c3f22a68cbb60619733"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/chef/#{version}/mac_os_x/#{MacOS.version}/chef-#{version}-1.dmg"
  name "Chef Infra Client"
  homepage "https://www.chef.io/"

  depends_on macos: ">= :high_sierra"

  pkg "chef-#{version}-1.pkg"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command "/usr/bin/find",
      args: ["/usr/local/bin", "-lname", "/opt/chef/*", "-delete"],
      sudo: true
  end

  uninstall pkgutil: "com.getchef.pkg.chef",
            delete:  "/opt/chef/"
end
