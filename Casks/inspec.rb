cask "inspec" do
  version "4.7.3"
  sha256 "21e347ab990293ef50a08eaec6ea5471962d01e6d30bcca1ed202b81574f01aa"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version}/mac_os_x/#{MacOS.version}/inspec-#{version}-1.dmg"
  appcast "https://github.com/chef/inspec/releases.atom"
  name "InSpec by Chef"
  homepage "https://www.inspec.io/"

  depends_on macos: ">= :sierra"

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
