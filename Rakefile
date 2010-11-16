require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the ancestree plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the ancestree plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Ancestree'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "ancestree"
    gemspec.summary = "Rails 3 plugin to inherit attributes"
    gemspec.description = "Ancestree is a Rails 3 plugin that makes inheriting properties from parent objects in tree-like structure simple."
    gemspec.email = "brian@heimidal.net"
    gemspec.homepage = "http://github.com/heimidal/ancestree"
    gemspec.authors = ["Brian Rose", "Gabe Varela"]
    gemspec.add_development_dependency('rspec', '~> 2.0.0')
    gemspec.add_dependency('activesupport', '~> 3.0.0')
    gemspec.add_dependency('activerecord', '~> 3.0.0')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Jeweler::GemcutterTasks.new
