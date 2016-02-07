require_relative 'gemfile'
require_relative 'rails_helper'
require_relative 'spec_helper'

class RspecInstall
  attr_reader :gemfile, :rails_helper, :spec_helper

  def initialize
    @gemfile = GemFile.new.rspec_gemfile
    @rails_helper = RailsHelper.new.rails_helper
    @spec_helper = SpecHelper.new.spec_helper
    @init = init
  end

  def check_for_spec
    if `ls`.include?('spec')
      puts "rspec already installed!"
    else
      `rails generate rspec:install`
      puts "rspec generated"
    end
  end

  def make_gemfile_and_bundle
    `rm -rf Gemfile`
    `echo "#{gemfile}" >> Gemfile`
    `bundle`
    puts "bundled"
  end

  def remove_test_dir_and_make_feature_dir
    `rm -rf test/`
    `mkdir spec/features`
    puts "made features and removed test dir"
  end

  def make_proper_spec_files_and_implement_capybara_and_dbcleaner
    `rm -rf spec/spec_helper.rb`
    `rm -rf spec/rails_helper.rb`
    `echo "#{spec_helper}" >> spec/spec_helper.rb`
    `echo "#{rails_helper}" >> spec/rails_helper.rb`
    puts "capybara and DBcleaner are now implemented!"
  end

  def init
    make_gemfile_and_bundle
    check_for_spec
    remove_test_dir_and_make_feature_dir
    make_proper_spec_files_and_implement_capybara_and_dbcleaner
  end
end

RspecInstall.new
