# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'UFCMobile' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UFCMobile
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

pod 'TextFieldEffects'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/RemoteConfig'
pod 'FirebaseUI'

pod 'JSSAlertView'




end
