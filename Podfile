source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def shared_pods
    pod 'FontAwesome.swift', :git => 'https://github.com/thii/FontAwesome.swift.git', :branch => 'master'
    pod 'SwiftPriorityQueue', '~> 1.1'
    pod 'SnapKit', '~> 3.0'
    pod 'RealmSwift'
end

target "Bram" do
    shared_pods
end

target "BramTests" do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
