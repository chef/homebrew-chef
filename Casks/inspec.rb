cask "inspec" do
  version "5.23.6"
  sha256 "c52c378ebdda1565f9c3bb8b18b4ee420e779f9255720830eb7a029a1e336a43"

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
