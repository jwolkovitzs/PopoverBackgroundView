#
# Be sure to run `pod lib lint PopoverBackgroundView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PopoverBackgroundView'
  s.version          = '1.0.0'
  s.summary          = 'PopoverBackgroundView replacement for iOS that allows fullscreen and background fadein animation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UIPopoverBackgroundView replacement for iOS that allows fullscreen and background fadein animation.

The PopoverBackgroundConditioner allows you to set the arrow size(defualt CGSize(width: 20, height: 10)), popover insets(defualt: UIEdgeInsets(top: -30, left: -10, bottom: -10, right: -10), allows for popover to use fullscreen), arrow color(defualt clear).

The PopoverBackgroundView sets it self as the currentBackground in the PopoverBackgroundConditioner. This allows you to proform animation on it later, such as fade in or change color

  DESC

  s.homepage         = 'https://github.com/jwolkovitzs/PopoverBackgroundView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jwolkovitzs' => 'JWolkovitz@gmail.com' }
  s.source           = { :git => 'https://github.com/jwolkovitzs/PopoverBackgroundView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'
  s.platform      = :ios, '8.0'

  s.source_files = 'PopoverBackgroundView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PopoverBackgroundView' => ['PopoverBackgroundView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
