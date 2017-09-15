Pod::Spec.new do |s|
s.name        = 'SFHttp'
s.version     = '1.0.2'
s.authors     = { 'ruibox001' => 'wangshengyuancrazy@163.com' }
s.homepage    = 'https://github.com/ruibox001/SFHttp'
s.summary     = 'SFHttp 是基于AFNetworking的封装的网络请求类'
s.source      = { :git => 'https://github.com/ruibox001/SFHttp.git',:tag => "v#{s.version}" }
s.license     = { :type => "MIT", :file => "LICENSE" }
s.platform = :ios, '8.0'
s.requires_arc = true
s.source_files  = "SFHttp", "SFHttp/**/*.{h,m}"
s.framework  = "UIKit"
s.ios.deployment_target = '8.0'
end