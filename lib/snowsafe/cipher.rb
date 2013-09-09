module Snowsafe

  module Cipher

    MODE = 'AES-256-CBC'

    def self.encrypt(cleartext, password)
      aes = cipher.encrypt
      aes.key = sha256 password
      iv = aes.random_iv
      ciphertext = aes.update(cleartext) + aes.final
      encoded_ciphertext = encode64 ciphertext
      EncryptedMessage.new(encoded_ciphertext, iv)
    end

    def self.decrypt(ciphertext, password, iv)
      decoded_ciphertext = decode64 ciphertext

      aes = cipher.decrypt
      aes.key = sha256 password
      aes.iv = iv
      aes.update(decoded_ciphertext) + aes.final
    end

    def self.cipher
      OpenSSL::Cipher::Cipher.new(MODE)
    end

    def self.iv
      cipher.random_iv
    end

    def self.sha256(cleartext)
      Digest::SHA2.new(256).digest(cleartext)
    end

    def self.toml_encode(data)
      TOML::Generator.new(data).body
    end

    def self.encode64(message)
      Base64.encode64(message).chomp!
    end

    def self.decode64(message)
      Base64.decode64 message
    end


    class EncryptedMessage
      attr_reader :ciphertext, :iv
      def initialize(ciphertext, iv)
        @ciphertext, @iv = ciphertext, iv
      end

      def iv_base64
        Cipher.encode64 @iv
      end

    end

  end

end
