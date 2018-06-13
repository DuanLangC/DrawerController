Pod::Spec.new do |s|
  s.name         = "ELDrawerController"
  s.version      = "0.1.0"
  s.summary      = "A NavigationDrawer slides in from the left or right "
  s.homepage     = "https://github.com/DuanLangC/DrawerController"
  s.license      = "MIT"
  s.author             = { "Eldis" => "duanlangc@gmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/DuanLangC/DrawerController.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"
  s.requires_arc = true
  s.swift_version = "4.0"
end
