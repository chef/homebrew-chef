cask "chefdk" do
  version "4.5.0"
  sha256 "78afbaf35aebd0257e58dd1388dfe5720b2412b341cfbed195b4c604830323eb"

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
