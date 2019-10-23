cask "chef-infra-client" do
  version "15.4.45"
  sha256 "91d9185bc51501e069b5eebac57c2ba235734656cf60a78850e99c9db13b6404"

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
