require 'thor'
module Climate
  class Cli < Thor

  desc "foo", "Prints foo"
  def foo
    puts "foo"
  end

  end
end
