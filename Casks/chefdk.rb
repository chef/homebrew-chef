cask "chefdk" do
  version "4.13.3"
  sha256 "a38e995e6a83856df64875dcc2424fe961b7dee9fca90a1290ddd1f01399ebf8"

  name "Chef Development Kit"
  name "ChefDK"
  homepage "https://www.chef.io/downloads/tools/chefdk"
  desc "DEPRECATED. Install Chef Workstation instead"

  depends_on macos: ">= :mojave"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command "/usr/bin/find",
      args: ["/usr/local/bin", "-lname", "/opt/chefdk/*", "-delete"],
      sudo: true
  end

  depends_on cask: "chef-workstation"

  uninstall pkgutil: "com.getchef.pkg.chefdk",
            delete:  "/opt/chefdk/"

  zap trash: "~/.chefdk/"
end
