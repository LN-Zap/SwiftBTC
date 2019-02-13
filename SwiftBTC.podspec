#
# Be sure to run `pod lib lint SwiftBTC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.swift_version    = '4.2'
  s.name             = 'SwiftBTC'
  s.version          = '0.0.8'
  s.summary          = 'Bitcoin specific convenience functions and types.'
  s.description      = <<-DESC
Network, p2pkh, p2sh & bech32 bitcoin addresses, bip-0021 URI scheme for making Bitcoin payments, Satoshi number type, Currency type
                       DESC

  s.homepage         = 'https://github.com/LN-Zap/SwiftBTC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Otto Suess' => 'ottosuess@protonmail.com' }
  s.source           = { :git => 'https://github.com/LN-Zap/SwiftBTC.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ottosuess'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftBTC/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'BigInt', '~> 3.1'
end
