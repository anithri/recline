# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

guard 'shell' do
  watch('bin/climate') { puts "running climate..."; puts `bundle exec bin/climate` + "\n" }
  watch(%r{^lib/(.*)\.rb$}) { puts "running climate..."; puts `bundle exec bin/climate` + "\n" }
end
