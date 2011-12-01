require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "binged"
    gem.summary = %Q{A wrapper for the bing api}
    gem.description = %Q{A wrapper for the bing api}
    gem.email = "kevin.faustino@gmail.com"
    gem.homepage = "http://github.com/kfaustino/binged"
    gem.authors = ["Kevin Faustino"]
    gem.add_dependency "hashie", "~>0.1.0"
    gem.add_dependency "crack", ">=0.1.6"
    gem.add_dependency "activesupport", ">=3.1.3"
    gem.add_development_dependency "rspec", ">= 1.3.0"
    gem.add_development_dependency "fakeweb", ">=1.2.8"
    gem.add_development_dependency "yard", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
