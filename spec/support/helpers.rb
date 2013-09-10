module TestHelpers

  def new_password
    SecureRandom.hex
  end

  def clear_fixtures!
    fixture_files = Dir.glob FIXTURE_DIR + "/**/*"
    fixture_files.each do |file|
      FileUtils.rm_rf file
    end
  end
end
