RSpec::Matchers.define :exist_on_disk do
  match do |path|
    File.exist?(path)
  end
end
