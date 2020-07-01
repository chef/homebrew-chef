cask "chef-workstation" do
  version "20.7.81"
  sha256 "1027d55e29c12dcedefe799b8d3a5b1bb19df4224a77eb5e87d0d623570cca63"

  url "https://packages.chef.io/files/stable/chef-workstation/#{version}/mac_os_x/10.13/chef-workstation-#{version}-1.dmg"
  name "Chef Workstation"
  homepage "https://www.chef.sh/"

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
