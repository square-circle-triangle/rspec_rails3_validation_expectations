require 'rake'

Gem::Specification.new do |s|
  s.name     = "rspec_rails3_validation_expectations"
  s.version  = "0.0.1"
  s.date     = "2011-01-10"
  s.summary  = "Adds expectations for testing ActiveRecord model validations."
  s.email    = "jitendra.vinsol@gmail.com"
  s.homepage = "http://github.com/jitendra/rspec_rails3_validation_expectations"
  s.description = "Forked from pelargir / rspec_validation_expectations and updated to work with Rails 3. Need to fix the test"
  s.rubyforge_project = "rspec_rails3_validation_expectations"
  s.has_rdoc = true
  s.authors  = ["Matthew Bass"]
  s.files    = FileList["[A-Z]*", "init.rb", "{lib,spec}/**/*.{rb,xml}"]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]
  s.add_development_dependency "activesupport", "3.0.3"
  s.add_development_dependency "activerecord", "3.0.3"
  s.add_development_dependency "validation_reflection", "1.0.0"
end
