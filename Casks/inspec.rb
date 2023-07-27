cask "inspec" do
  version "5.12.2"
  sha256 "e9af397a31cd08ae34ddfe8fe438719b8dc57e954c3eeebfb201e8ee645adeb6"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version}/mac_os_x/12/inspec-#{version}-1.x86_64.dmg"

  livecheck do
    url "https://github.com/chef/inspec/releases.atom"
    strategy :page_match
    regex(%r{href=.*?\/inspec\/releases\/tag/v(\d+(?:\.\d+)*)}i)
  end

  name "InSpec by Chef"
  homepage "https://community.chef.io/tools/chef-inspec/"

  depends_on macos: ">= :catalina"

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
