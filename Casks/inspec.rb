cask "inspec" do
  version "4.24.28"
  sha256 "d7023785512eae8c2e18128757026897ec095b2475b1d3cddc543b199c2f0a40"

  # big sur and later aggressively releases feature versions, which don't match our download versions
  # for example macOS 11.1 needs to map to 11.0
  if MacOS.version >= "11.0"
    macos_version = "11.0"
  else
    macos_version = MacOS.version
  end

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version}/mac_os_x/#{macos_version}/inspec-#{version}-1.dmg"
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
