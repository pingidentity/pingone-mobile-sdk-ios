Pod::Spec.new do |spec|
  spec.name               = "PingOneSDK"
  spec.version            = "1.7.2"
  spec.summary            = "PingOneSDK Library for iOS"
  spec.description        = "PingOneSDK Pod Library for iOS apps"
  spec.homepage           = "https://github.com/pingidentity/pingone-mobile-sdk-ios"
  spec.documentation_url  = "https://github.com/pingidentity/pingone-mobile-sdk-ios"
  spec.license            = { :type => "MIT" }
  spec.author             = { "PingOneSDK" => "..." }
  spec.source             = { :git => 'https://github.com/pingidentity/pingone-mobile-sdk-ios.git', :tag => "v#{spec.version}" }
  spec.swift_version      = "5.3"

  # Supported deployment targets
  spec.ios.deployment_target  = "12.4"

  spec.dependency 'AppAuth', '~> 1.6.0'
  # Published binaries
  spec.vendored_frameworks = "SDK/PingOneSDK.xcframework"
end