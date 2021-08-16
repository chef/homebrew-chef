cask "inspec" do
  version "4.41.2"
  sha256 "382370e8a6f7c73c5a86b5e94da604eb290765dcb1ae6d50099e1b4d0671bc8b"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version}/mac_os_x/10.14/inspec-#{version}-1.x86_64.dmg"
  appcast "https://github.com/chef/inspec/releases.atom"
  name "InSpec by Chef"
  homepage "https://community.chef.io/tools/chef-inspec/"

  depends_on macos: ">= :high_sierra"

  pkg "inspec-#{version}-1.x86_64.pkg"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command "/usr/bin/find",
      args: ["/usr/local/bin", "-lname", "/opt/inspec/*", "-delete"],
      sudo: true
  end

  uninstall pkgutil: "com.getchef.pkg.inspec",
            delete:  "/opt/inspec/"

  zap trash: "~/.inspec/"
end
