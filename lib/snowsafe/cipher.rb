module Snowsafe

  ##
  # This module should centralize all critical cryptographic logic for ease of auditing.
  #
  module Cipher

    MODE = 'AES-256-CBC'

    def self.encrypt(cleartext, password: random_key, iv: random_iv)
      aes = new_cipher.encrypt

      key_digest = sha256 password

      aes.key = key_digest
      aes.iv = iv

      ciphertext = aes.update(cleartext) + aes.final

      EncryptedMessage.new(ciphertext, password, iv)
    end

    def self.decrypt(ciphertext, password, iv: nil)
      decoded_ciphertext = decode64 ciphertext

      aes = new_cipher.decrypt
      aes.key = sha256 password
      aes.iv = iv if iv
      aes.update(decoded_ciphertext) + aes.final
    end

    def self.new_cipher
      OpenSSL::Cipher.new(MODE)
    end

    def self.sha256(str)
      Digest::SHA256.new.digest(str)
    end

    def self.random_key
      encode64 new_cipher.random_key
    end

    def self.random_iv
      encode64 new_cipher.random_iv
    end

    def self.toml_encode(data)
      TOML::Generator.new(data).body
    end

    def self.toml_decode(data)
      TOML::Parser.new(data).parsed
    end

    def self.encode64(message)
      Base64.encode64(message).chomp!
    end

    def self.decode64(message)
      Base64.decode64 message
    end

    def self.uuid
      SecureRandom.uuid
    end

    class EncryptedMessage
      attr_reader :ciphertext, :key, :iv

      def initialize(ciphertext, key, iv)
        @ciphertext, @key, @iv = ciphertext, key, iv
      end

      def ciphertext_base64
        @ciphertext_base64 ||= Cipher.encode64 @ciphertext
      end

    end
  end

end
