cask "chefdk" do
  version "3.6.57"
  sha256 "c3b16550222a707e5d8489d8bbe612950815b0a114f31f79e52e329ac4e17297"

  url "https://packages.chef.io/files/stable/chefdk/#{version}/mac_os_x/#{MacOS.version}/chefdk-#{version}-1.dmg"
  appcast "https://www.chef.io/chef/metadata-chefdk?p=mac_os_x&pv=#{MacOS.version}&m=x86_64&v=latest&prerelease=false"
  name "Chef Development Kit"
  name "ChefDK"
  homepage "https://downloads.chef.io/chefdk"

  depends_on macos: ">= :sierra"

  pkg "chefdk-#{version}-1.pkg"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command "/usr/bin/find",
                   args: ["/usr/local/bin", "-lname", "/opt/chefdk/*", "-delete"],
                   sudo: true
  end

  uninstall pkgutil: "com.getchef.pkg.chefdk",
            delete:  "/opt/chefdk/"

  zap trash: "~/.chefdk/"
end
