cask "chef-infra-client" do
  version "16.9.16"
  sha256 "3cb8d84a715c7f63b249b2f69e042889515eba9a6e82d41b7630861bce4728fa"

  # big sur and later aggressively releases feature versions, which don't match our download versions
  # for example macOS 11.1 needs to map to 11.0
  if MacOS.version >= "11.0"
    macos_version = "11.0"
  else
    macos_version = MacOS.version
  end

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/chef/#{version}/mac_os_x/#{macos_version}/chef-#{version}-1.dmg"
  name "Chef Infra Client"
  homepage "https://community.chef.io/tools/chef-infra/"

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
