Pod::Spec.new do |s|
s.name = 'JJVideoManagerKit'
s.version = '1.0.3'
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary = 'JJVideoManagerKit is  Video compression'
s.homepage = 'https://github.com/ljj756640646/JJVideoManagerKit'
s.authors = { 'lujunjie' => '756640646@qq.com' }
s.source = { :git => 'https://github.com/ljj756640646/JJVideoManagerKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '9.0'
s.source_files = 'JJVideoManagerKit/VideoManagerKit/*.{h,m}'



end