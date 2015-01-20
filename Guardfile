group :dev, halt_on_fail: true do
  guard :rspec, all_on_start: false, all_after_pass: false, failed_mode: :keep, cmd: 'bundle exec rspec' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')                        { 'spec' }
    watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
  end

  guard :rubocop, all_on_start: false, all_after_pass: false do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end

# default group
scope group: :dev
