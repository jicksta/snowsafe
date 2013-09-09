require 'spec_helper'

module Snowsafe
  describe Cipher do

    let(:message) { "Fuck the NSA!" }
    let(:key) { rand.to_s }

    it "can decrypt what it encrypts" do
      encrypted = Cipher.encrypt(message, key)
      decrypted = Cipher.decrypt(encrypted.ciphertext, key, encrypted.iv)
      decrypted.should == message
    end

    describe Cipher::EncryptedMessage do

      it "exposes getters for its ciphertext and iv" do
        message = Cipher::EncryptedMessage.new("ciphertext", "iv")
        message.ciphertext.should == "ciphertext"
        message.iv.should == "iv"
      end

      describe "#iv_base64" do
        it "returns the Base64 encoded text of the IV" do
          iv = "0123456789ABCDEF"
          message = Cipher::EncryptedMessage.new("ciphertext", iv)
          message.iv_base64.should == Cipher.encode64(iv)
        end
      end

    end

  end
end
