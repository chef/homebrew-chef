cask "chefdk" do
  version "4.13.3"

  name "Chef Development Kit"
  name "ChefDK"
  url "https://chef.io"
  homepage "https://www.chef.io/downloads/tools/chefdk"
  desc "DEPRECATED. This package now installs Chef Workstation"

  depends_on macos: ">= :catalina"

  stage_only true

  depends_on cask: "chef-workstation"
end
