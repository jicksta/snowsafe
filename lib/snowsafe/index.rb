module Snowsafe
  class Index

    FILE_NAME = "index.ss"

    def self.generate(dir)
      filename = index_filename_from_dir(dir)
      write_index(filename, blank_index_template)
      new(filename)
    end

    def self.index_filename_from_dir(dir)
      File.join dir, FILE_NAME
    end

    def self.write_index(file_or_path, data)
      toml_content = Cipher.toml_encode data
      writer = -> file { file.write toml_content }
      if file_or_path.kind_of?(File)
        writer.call(file_or_path)
      else
        FileUtils.touch file_or_path
        File.open(file_or_path, 'r+', &writer)
      end
    end

    def self.blank_index_template
      {
          version: Snowsafe::VERSION,
          created_at: Time.now.to_i,
          iv: SecureRandom.hex,
          entries: {},
          # hidden_files: false, # Looks for files with the name .8dec1b9f-3263-4a84-bbe2-51ef6ff1dba1
          # update_timestamp: true, # If set to false, no timestamps will be written
      }
    end

    attr_reader :path

    def initialize(path)
      raise ArgumentError unless File.exists?(path)

      @path = path
      @dir = File.dirname @path
    end

    def add_entry(password, entry_data)
      Entry.new_from_data(@dir, entry_data) do |uuid, encrypted_entry|
        with_parsed_index do |index_data, file|
          encrypted_entry_key = Cipher.encrypt(encrypted_entry.key, password: password, iv: uuid)

          index_data["entries"] ||= {}
          index_data["entries"][uuid] = encrypted_entry_key.ciphertext_base64

          self.class.write_index(file, index_data)
        end
      end
    end

    def decrypt_entry(uuid, password)
      encrypted_entry = encrypted_entries.find { |entry| entry.uuid == uuid }
      return unless encrypted_entry

      entry_key = Cipher.decrypt(encrypted_entry.encrypted_key, password, iv: uuid)

      encrypted_entry.decrypt entry_key
    end

    def encrypted_entries
      data = contents
      return [] if data["entries"].nil?

      data["entries"].map do |uuid, encrypted_key|
        EncryptedEntry.new(uuid, encrypted_key, @dir)
      end
    end

    def contents
      Cipher.toml_decode File.read(@path)
    end

    class EncryptedEntry < Struct.new(:uuid, :encrypted_key, :dir)
      def path
        File.join(dir, uuid)
      end

      def decrypt(password)
        ciphertext = File.read(path)

        toml_data = Cipher.decrypt(ciphertext, password, iv: uuid)
        data = Cipher.toml_decode toml_data

        Entry.new(path, data)
      end
    end

    private

    def with_parsed_index(&block)
      File.open(@path, "r+") do |file|
        toml_data = file.read

        data = Cipher.toml_decode(toml_data)
        file.rewind

        block.call(data, file)
      end
    end

  end
end
