Pod::Spec.new do |s|
  s.name             = 'Instantiate'
  s.version          = '4.0.0'
  s.summary          = 'Type-safe InterfaceBuilder protocols.'
  s.description      = <<-DESC
Storyboard and Nib is not type safe, if you use `UIStoryboard` or `UINib`, your code would be get some gloom.
Instantiate take type-safe protocols for Storyboard and Nib. Lets' improve our code with type-safe protocols!
                       DESC
  s.homepage         = 'https://github.com/tarunon/Instantiate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tarunon' => 'croissant9603@gmail.com' }
  s.source           = { :git => 'https://github.com/tarunon/Instantiate.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Sources/Instantiate/**/*'
end
