spec = Gem::Specification.new do |s|
  s.name = 'rakeutil'
  s.version = "1.0.0"
 
  s.author = "CastTV"
  s.email = "kyle@casttv.com"
  s.homepage = "http://www.casttv.com/"
  s.summary = "Rake Utilities"
  s.description = "Making my life easier"
 
  s.platform = Gem::Platform::RUBY
  s.files = %w[README INSTALL lib/rakeutil.rb]
 
  # s.rdoc_options << '--exclude' << '.'
  # s.has_rdoc = false
 
  s.require_path = 'lib'
  s.autorequire = 'rakeutil'
 
end