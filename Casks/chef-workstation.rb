cask "chef-workstation" do
  version "22.1.745"
  sha256 "f6beaa7b00ecb062d541648e6562c9dba3c5380176c2cef612518b114cee712a"

  url "https://packages.chef.io/files/stable/chef-workstation/#{version}/mac_os_x/10.15/chef-workstation-#{version}-1.x86_64.dmg"
  name "Chef Workstation"
  desc "Packages all the tools necessary to be successful with Chef Infra and InSpec"
  homepage "https://community.chef.io/tools/chef-workstation/"

  depends_on macos: ">= :catalina"

  pkg "chef-workstation-#{version}-1.x86_64.pkg"

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
