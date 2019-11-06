cask "chef-infra-client" do
  version "14.14.29"
  sha256 "08e6fcc8f67a3ae3512fc50faa9afc73df67321c12e340dc2b8eb909a5069c8e"

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
