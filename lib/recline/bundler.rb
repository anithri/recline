require 'thor/group'
module Recline
  class Bundler < Thor::Group

    method_option :gemset, :type => :string, :default => :all, :desc => "Which gemset to operate on"
    def install

    end
  end
end
