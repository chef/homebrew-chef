cask "chefdk" do
  version "4.13.3"

  name "Chef Development Kit"
  name "ChefDK"
  url "https://packages.chef.io/files/stable/chefdk/#{version}/mac_os_x/10.14/chefdk-#{version}-1.dmg"
  homepage "https://www.chef.io/downloads/tools/chefdk"
  desc "DEPRECATED. This package now installs Chef Workstation"

  depends_on macos: ">= :catalina"

  stage_only true

  depends_on cask: "chef-workstation"
end
