Pod::Spec.new do |s|
  s.name         = "ELDrawerController"
  s.version      = "0.0.1"
  s.summary      = "A NavigationDrawer slides in from the left or right "
  s.homepage     = "https://github.com/DuanLangC/DrawerController"
  s.license      = "MIT"
  s.author             = { "Eldis" => "duanlangc@gmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/DuanLangC/DrawerController.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"
  s.requires_arc = true
  s.swift_version = "4.0"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
