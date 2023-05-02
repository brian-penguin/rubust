# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"

require "rb_sys/extensiontask"

task build: :compile

RbSys::ExtensionTask.new("rubust") do |ext|
  ext.lib_dir = "lib/rubust"
end

task default: %i[compile test standard]
