module Snowsafe
  class Entry

    ##
    # This writes a new encrypted entry to the given directory, yielding the UUID and encrypted data to the block.
    #
    def self.new_from_data(dir, entry_data, &block)
      uuid = Cipher.uuid
      path = File.join(dir, uuid)

      toml_data = Cipher.toml_encode(entry_data)
      encrypted = Cipher.encrypt toml_data, iv: uuid

      File.open(path, "w") do |file|
        file.write encrypted.ciphertext_base64
        file.flush

        block.call(uuid, encrypted) # Yield while retaining write lock on file
      end

      new(path, entry_data)

      #rescue Exception
      #  FileUtils.rm filename
    end

    attr_reader :uuid, :path, :data
    def initialize(path, data)
      @path = path
      @uuid = File.basename path
      @data = data
    end

  end
end
