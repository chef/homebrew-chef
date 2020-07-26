cask "chefdk" do
  version "4.9.7"
  sha256 "794e2c003e6012681d88bf71165f90a243dd0fd94b5bc0edc9466b4744847208"

  url "https://packages.chef.io/files/stable/chefdk/#{version}/mac_os_x/#{MacOS.version}/chefdk-#{version}-1.dmg"
  appcast "https://www.chef.io/chef/metadata-chefdk?p=mac_os_x&pv=#{MacOS.version}&m=x86_64&v=latest&prerelease=false"
  name "Chef Development Kit"
  name "ChefDK"
  homepage "https://downloads.chef.io/chefdk"

  depends_on macos: ">= :high_sierra"

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
