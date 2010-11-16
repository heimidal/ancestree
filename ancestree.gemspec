# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ancestree}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Rose", "Gabe Varela"]
  s.date = %q{2010-11-16}
  s.description = %q{Ancestree is a Rails 3 plugin that makes inheriting properties from parent objects in tree-like structure simple.}
  s.email = %q{brian@heimidal.net}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "MIT-LICENSE",
     "README",
     "Rakefile",
     "VERSION",
     "ancestree.gemspec",
     "init.rb",
     "install.rb",
     "lib/ancestree.rb",
     "spec/inherit_ancestor_attributes_spec.rb",
     "spec/spec_helper.rb",
     "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/heimidal/ancestree}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Rails 3 plugin to inherit attributes}
  s.test_files = [
    "spec/inherit_ancestor_attributes_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.0.0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.0.0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
  end
end

