cask 'chefdk' do
  version '3.0.36'
  sha256 'fb641d694a7545949df2fd6e94a53b5da4b6085b60ac9f742ef8d3079fd0c8e4'

  url "https://packages.chef.io/files/stable/chefdk/#{version}/mac_os_x/10.13/chefdk-#{version}-1.dmg"
  appcast "https://www.chef.io/chef/metadata-chefdk?p=mac_os_x&pv=#{MacOS.version}&m=x86_64&v=latest&prerelease=false",
          checkpoint: 'ee66291c945a890f9c5c79cef3e2de9280615d98dfaef080fe77d1e66bad522b'
  name 'Chef Development Kit'
  name 'ChefDK'
  homepage 'https://downloads.chef.io/chefdk'

  depends_on macos: '>= :el_capitan'

  pkg "chefdk-#{version}-1.pkg"

  # As suggested in https://docs.chef.io/install_dk.html#mac-os-x
  uninstall_postflight do
    system_command '/usr/bin/find',
                   args: ['/usr/local/bin', '-lname', '/opt/chefdk/*', '-delete'],
                   sudo: true
  end

  uninstall pkgutil: 'com.getchef.pkg.chefdk',
            delete:  '/opt/chefdk/'

  zap trash: '~/.chefdk/'
end
