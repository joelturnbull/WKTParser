Pod::Spec.new do |s|
  s.name         = "WKTParser"
  s.version      = "0.0.1"
  s.summary      = "A library for parsing geometries from Well-Known-Text (WKT)."
  s.homepage     = "https://github.com/joelturnbull/WKTParser"
  s.license      = 'MIT'
  s.authors      = { "Joel Turnbull" => "joelbywan@gmail.com", "Peter Kananen" => "peter@gaslight.co" }
  s.source       = { :git => "https://github.com/adamhadani/WKTParser.git", :tag => "master" }
  s.platform     = :ios, '5.0'
  s.source_files = 'WKTParser'
  s.frameworks   = 'MapKit', 'CoreLocation'
  s.requires_arc = true
end
