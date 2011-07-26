require 'configatron_plus'
require 'recline/bundler.rb'

module Recline
  class Cli < Thor
    include Thor::Actions
    add_runtime_options!

    configatron.set_default(:conf_file,  ENV['RECLINE_CONF_FILE']   || '~/.config/recline/recline.conf' )
    configatron.conf.set_default(:gemfile_dir,ENV['RECLINE_GEMFILE_DIR'] || '~/.config/recline' )
    configatron.conf.set_default(:bin_dir,    ENV['RECLINE_BIN_DIR']     || '~/.config/recline')


    class_option :conf_file, :type =>:string, :aliases => "-c",
                 :desc => "The path to the recline.conf file.  Also uses $RECLINE_CONF_FILE",
                 :default => configatron.conf_file

    class_option :foo, :default => "bar"
    desc "init", "Creates the recline.conf file."
    long_desc "Creates the recline.conf file and populates settings using gemfile_dir and bin_dir"
    method_option :gemfile_dir, :type => :string, :aliases => '-g',
                  :desc => "The path to the directory used to store Gemfiles",
                  :default => configatron.conf.gemfile_dir
    method_option :bin_dir, :type => :string, :aliases => '-b',
                      :desc => "The path to the directory used to store gem based binaries",
                      :default => configatron.conf.bin_dir
    def init
      template "templates/recline.conf.erb", options.conf_file
    end

    desc "show_options", "Prints the current options in use"
    def show_options
      puts configatron.inspect
    end

    register Recline::Bundler, "install", "bundle-install", "install gemfiles"
    
    def initialize(*args)
      super(args)
      options.keys.each do |key|
        configatron.send("#{key}=", options[key])
      end
      file = File.expand_path(configatron.conf_file)
      if File.exist?(file)
        say "reading conf file"
        configatron.configatron_plus.sources = [file]
        ConfigatronPlus.fetch_sources
      end
    end
    
    private
    def self.source_root
      File.dirname(__FILE__)
    end

  end
end
