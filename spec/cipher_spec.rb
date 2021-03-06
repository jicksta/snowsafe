require 'spec_helper'

module Snowsafe
  describe Cipher do

    let(:message) { "Fuck the NSA!" }
    let(:key) { "password" }

    it "can decrypt what it encrypts" do
      encrypted = Cipher.encrypt(message, password: key)
      decrypted = Cipher.decrypt(encrypted.ciphertext_base64, key, iv: encrypted.iv)
      decrypted.should == message
    end

    it "can encrypt messages with short passwords" do
      expect do
        %w[a ab abc abcd].each do |password|
          Cipher.encrypt(message, password: password)
        end
      end.not_to raise_error
    end

    describe "TOML encoding" do
      it "encodes and decodes" do
        data = {"one" => 1, "two" => "2", "three" => {"german" => "drei", "spanish" => "tres"}}
        encoded = Cipher.toml_encode(data)
        Cipher.toml_decode(encoded).should == data
      end
    end

    describe Cipher::EncryptedMessage do

      it "exposes getters for its ciphertext, key and iv" do
        message = Cipher::EncryptedMessage.new("ciphertext", "key", "iv")
        message.ciphertext.should == "ciphertext"
        message.key.should == "key"
        message.iv.should == "iv"
      end

    end

  end
end
