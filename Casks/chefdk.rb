cask 'chefdk' do
  version '3.1.0'
  sha256 '669a5cd0b0ade114a84c65f5dece8da8847dfad942b3fec08aacf061aa15611a'

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
