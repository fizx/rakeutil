spec = Gem::Specification.new do |s|
  s.name = 'rakeutil'
  s.version = "1.0.0"
 
  s.author = "CastTV"
  s.email = "kyle@casttv.com"
  s.homepage = "http://www.casttv.com/"
  s.summary = "Rake Utilities"
  s.description = "Making my life easier"
 
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("{bin,doc,etc,lib,sample,test}/**/*").delete_if {|item| item.include?("CVS") || item.include?("rdoc")}
  s.files.concat ["README", "README.DEV", "ChangeLog", "INSTALL"]
 
  # s.rdoc_options << '--exclude' << '.'
  # s.has_rdoc = false
 
  s.require_path = 'lib'
  s.autorequire = 'rakeutil'
 
end
 
if $0 == __FILE__
  Gem::manage_gems
  Gem::Builder.new(spec).build
end