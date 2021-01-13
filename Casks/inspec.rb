cask "inspec" do
  version "4.24.32"
  sha256 "11e38cd3d5a66acadef9dd2a23432dab5385fea8a01ead8cc7814789da5aeb4a"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version}/mac_os_x/10.14/inspec-#{version}-1.dmg"
  appcast "https://github.com/chef/inspec/releases.atom"
  name "InSpec by Chef"
  homepage "https://community.chef.io/tools/chef-inspec/"

  depends_on macos: ">= :high_sierra"

  pkg "inspec-#{version}-1.pkg"

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
