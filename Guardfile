# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

guard 'shell' do
  watch('bin/recline') { puts "running recline..."; puts `bundle exec bin/recline` + "\n" }
  watch(%r{^lib/(.*)\.rb$}) { puts "running recline..."; puts `bundle exec bin/recline` + "\n" }
end
