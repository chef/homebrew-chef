cask "chef-infra-client" do
  version "17.5.22"
  sha256 "e3f2d4e2a4c7c202cbab7d1fc0856a23f04727ed57f70676f2cb01c75c3d1685"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/chef/#{version}/mac_os_x/10.14/chef-#{version}-1.x86_64.dmg"
  name "Chef Infra Client"
  homepage "https://community.chef.io/tools/chef-infra/"

  depends_on macos: ">= :high_sierra"

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
