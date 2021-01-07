cask "chef-workstation" do
  version "21.1.222"
  sha256 "c1a3ee7290b25366b3c6b002948d13c880fe627e2e7026825dde46baf45b3b96"

  # big sur and later aggressively releases feature versions, which don't match our download versions
  # for example macOS 11.1 needs to map to 11.0
  if MacOS.version >= "11.0"
    macos_version = "11.0"
  else
    macos_version = MacOS.version
  end

  url "https://packages.chef.io/files/stable/chef-workstation/#{version}/mac_os_x/#{macos_version}/chef-workstation-#{version}-1.dmg"
  name "Chef Workstation"
  homepage "https://community.chef.io/tools/chef-workstation/"

  depends_on macos: ">= :high_sierra"

  pkg "chef-workstation-#{version}-1.pkg"

  # When updating this cask, please verify the list of paths to delete and correct it if necessary:
  #   find /usr/local/bin -lname '/opt/chef-workstation/*' | sed -E "s/^(.*)$/'\1',/"
  uninstall quit:    "sh.chef.chef-workstation",
            pkgutil: "com.getchef.pkg.chef-workstation",
            delete:  [
                       "/Applications/Chef Workstation App.app",
                       "/opt/chef-workstation/",
                       "/usr/local/bin/berks",
                       "/usr/local/bin/chef",
                       "/usr/local/bin/chef-cli",
                       "/usr/local/bin/chef-analyze",
                       "/usr/local/bin/chef-apply",
                       "/usr/local/bin/chef-client",
                       "/usr/local/bin/chef-run",
                       "/usr/local/bin/chef-shell",
                       "/usr/local/bin/chef-solo",
                       "/usr/local/bin/chef-vault",
                       "/usr/local/bin/chefx",
                       "/usr/local/bin/cookstyle",
                       "/usr/local/bin/dco",
                       "/usr/local/bin/delivery",
                       "/usr/local/bin/foodcritic",
                       "/usr/local/bin/habitat",
                       "/usr/local/bin/inspec",
                       "/usr/local/bin/kitchen",
                       "/usr/local/bin/knife",
                       "/usr/local/bin/ohai",
                       "/usr/local/bin/push-apply",
                       "/usr/local/bin/pushy-client",
                       "/usr/local/bin/pushy-service-manager",
                       "/usr/local/bin/uninstall_chef_workstation",
                     ]

  zap trash: "~/.chef-workstation/"
end
