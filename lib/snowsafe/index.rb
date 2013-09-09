module Snowsafe
  class Index

    FILE_NAME = "index"

    def self.generate(dir, password)
      filename = File.join dir, FILE_NAME

      secure_content = Cipher.toml_encode entries: []
      encrypted_content = Cipher.encrypt(secure_content, password)

      insecure_content = Cipher.toml_encode \
          version: Snowsafe::VERSION,
          created_at: Time.now.to_i,
          index: encrypted_content.ciphertext,
          iv: encrypted_content.iv_base64

      File.open(filename, "w+") do |file|
        file.write insecure_content
      end

      new(filename)
    end

    attr_reader :path
    def initialize(path)
      @path = path
    end

  end
end
