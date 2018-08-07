cask "inspec" do
  version "2.2.55-1"
  sha256 "78e29d088532173c00282f9bf9a95273d4523e1f29962b8b91c599149b1e163d"

  # packages.chef.io was verified as official when first introduced to the cask
  url "https://packages.chef.io/files/stable/inspec/#{version.major_minor_patch}/mac_os_x/10.13/inspec-#{version}.dmg"
  appcast "https://github.com/chef/inspec/releases.atom"
  name "InSpec by Chef"
  homepage "https://www.inspec.io/"

  pkg "inspec-#{version}.pkg"

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
