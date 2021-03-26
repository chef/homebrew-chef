cask "chef-infra-client" do
  version "16.11.7"

  # packages.chef.io was verified as official when first introduced to the cask
  if Hardware::CPU.intel?
    url "https://packages.chef.io/files/stable/chef/#{version}/mac_os_x/10.14/chef-#{version}-1.x86_64.dmg"
    sha256 "49af5f17c92378374fcb0fa65e78d7a48dee928a7a19edca24186d695120bedf"
  end
  name "Chef Infra Client"
  desc "Infrastructure client for Chef"
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
