cask "inspec" do
  version "4.18.100"
  sha256 "326dc41e4870eb5ebf397d0f875c823b22b3f9a2d4e20557c35a87dc145b4975"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version}/mac_os_x/#{MacOS.version}/inspec-#{version}-1.dmg"
  appcast "https://github.com/chef/inspec/releases.atom"
  name "InSpec by Chef"
  homepage "https://www.inspec.io/"

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
