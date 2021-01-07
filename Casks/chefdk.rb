cask "chefdk" do
  version "4.13.3"
  sha256 "a38e995e6a83856df64875dcc2424fe961b7dee9fca90a1290ddd1f01399ebf8"

  # big sur and later aggressively releases feature versions, which don't match our download versions
  # for example macOS 11.1 needs to map to 11.0
  if MacOS.version >= "11.0"
    macos_version = "11.0"
  else
    macos_version = MacOS.version
  end

  url "https://packages.chef.io/files/stable/chefdk/#{version}/mac_os_x/#{macos_version}/chefdk-#{version}-1.dmg"
  appcast "https://www.chef.io/chef/metadata-chefdk?p=mac_os_x&pv=#{macos_version}&m=x86_64&v=latest&prerelease=false"
  name "Chef Development Kit"
  name "ChefDK"
  homepage "https://downloads.chef.io/chefdk"

  depends_on macos: ">= :high_sierra"

  pkg "chefdk-#{version}-1.pkg"

  conflicts_with cask: "chef-workstation"

  caveats "ChefDK is officially EOL as of 12/31/2020. Install Chef Workstation instead `brew install --cask chef-workstation`"

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
