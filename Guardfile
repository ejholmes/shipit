# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})
  watch(%r{^lib/shipit/(.+)\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
end

