cask "chef-infra-client" do
  version "15.11.8"
  sha256 "28579747e3e37553e09c7e4883ee0961fc9ca007af6dd3293fdf0eac5211576d"

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
