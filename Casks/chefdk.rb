cask "chefdk" do
  version "3.4.38"
  sha256 "096248974211830433d0e4367f6f0c074a9e7d744146fac86a236ed78d0e2f18"

  url "https://packages.chef.io/files/stable/chefdk/#{version}/mac_os_x/#{MacOS.version}/chefdk-#{version}-1.dmg"
  appcast "https://www.chef.io/chef/metadata-chefdk?p=mac_os_x&pv=#{MacOS.version}&m=x86_64&v=latest&prerelease=false"
  name "Chef Development Kit"
  name "ChefDK"
  homepage "https://downloads.chef.io/chefdk"

  depends_on macos: ">= :el_capitan"

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
