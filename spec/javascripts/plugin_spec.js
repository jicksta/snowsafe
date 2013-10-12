describe("Plugin", function() {


  describe("Base64", function() {
    it("encodes and decodes known textual values", function() {
      expect(Plugin.decode64("SmF5IFBoaWxsaXBz")).toEqual("Jay Phillips");
      expect(Plugin.encode64("Jay Phillips")).toEqual("SmF5IFBoaWxsaXBz");
    });
  });

  describe("AES", function() {

    it("encrypts consistently with known standards", function() {
      var message = "Jay",
          password = "password",
          iv = "1234567890123456";

      var encrypted = Plugin.encrypt(message, password, {iv: iv});

      expect(encrypted).toEqual("t8Yltfp5Mdx4mcFLtnJ+Mw==");
    });

    it("decrypts what it encrypts", function() {
      var password = "abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabc",
          message = "Fuck the NSA!",
          iv = "1234567890123456";

      var encrypted = Plugin.encrypt(message, password, {iv: iv});
      var decrypted = Plugin.decrypt(encrypted, password, {iv: iv});

      expect(decrypted).toEqual(message);
    });

    it("returns an encrypted String", function() {
      var encryptedText = Plugin.encrypt("message", "password", {iv: "1234567890123456"});
      expect(_.isString(encryptedText)).toEqual(true);
    });

  });

  describe("with an index file", function() {

    var indexTOML;

    beforeEach(function() {
      indexTOML = "created_at = 1379177708\niv = \"oDovga1l5YQ0qQPlxVx-vw\"\nversion = \"0.1.0\"\n\n[entries]\n6b1a29d8-2594-47e1-9d2e-b6e07b16631f = \"NyAIGv06c9XUKy3ph0+iOPqJW8TnLlECUSph+WxCZI+wL+IU3Ec0Me6D7Gee\\nGecM\""
    });

  });

});
