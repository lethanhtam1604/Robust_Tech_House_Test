source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

def shared_pods
    pod 'SwiftLint'
    pod 'Alamofire'
    pod 'ObjectMapper'
    pod 'AlamofireObjectMapper'
end

target 'RTHTest' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
