require 'configatron_plus'
require 'climate/bundler.rb'

module Climate
  class Cli < Thor
    include Thor::Actions
    add_runtime_options!

    configatron.set_default(:conf_file,  ENV['CLIMATE_CONF_FILE']   || '~/.config/climate/climate.conf' )
    configatron.conf.set_default(:gemfile_dir,ENV['CLIMATE_GEMFILE_DIR'] || '~/.config/climate' )
    configatron.conf.set_default(:bin_dir,    ENV['CLIMATE_BIN_DIR']     || '~/.config/climate')


    class_option :conf_file, :type =>:string, :aliases => "-c",
                 :desc => "The path to the climate.conf file.  Also uses $CLIMATE_CONF_FILE",
                 :default => configatron.conf_file

    class_option :foo, :default => "bar"
    desc "init", "Creates the climate.conf file."
    long_desc "Creates the climate.conf file and populates settings using gemfile_dir and bin_dir"
    method_option :gemfile_dir, :type => :string, :aliases => '-g',
                  :desc => "The path to the directory used to store Gemfiles",
                  :default => configatron.conf.gemfile_dir
    method_option :bin_dir, :type => :string, :aliases => '-b',
                      :desc => "The path to the directory used to store gem based binaries",
                      :default => configatron.conf.bin_dir
    def init
      template "templates/climate.conf.erb", options.conf_file
    end

    desc "show_options", "Prints the current options in use"
    def show_options
      puts configatron.inspect
    end

    register Climate::Bundler, "install", "bundle-install", "install gemfiles"
    
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
