var Plugin = {

  encode64: function(message) {
    return CryptoJS.enc.Utf8.parse(message).toString(CryptoJS.enc.Base64);
  },

  decode64: function(message) {
    return CryptoJS.enc.Base64.parse(message).toString(CryptoJS.enc.Utf8);
  },

  encrypt: function(plaintext, password, options) {
    var key = this.sha256(password);
    var encrypted = CryptoJS.AES.encrypt(plaintext, key, this._sanitizeOptions(options));
    return encrypted.ciphertext.toString(CryptoJS.enc.Base64);
  },

  decrypt: function(ciphertext64, password, options) {
    var ciphertext = CryptoJS.enc.Base64.parse(ciphertext64);
    var key = this.sha256(password);

    var decrypted = CryptoJS.AES.decrypt(ciphertext, key, this._sanitizeOptions(options));
    return decrypted.toString(CryptoJS.enc.Utf8);
  },

  sha256: function(message) {
    return CryptoJS.SHA256(message);
  },

  _sanitizeOptions: function(options) {
    if (options && options.iv) {
      return {
        iv: CryptoJS.enc.Latin1.parse(options.iv)
      }
    } else {
      return {};
    }
  }

};


/*
 function passwordStuff() {
 var $master = $("input#master");

 $master.on("keypress", function(e) {
 if (e.which === 13) {
 tryPassword($master.val());
 e.preventDefault();
 }
 });

 var indexTOML = $("script#index-toml").html();
 var index = TOML.parse(indexTOML.trim());

 var encryptedEntry = $("script#entry").html().trim();

 var entryKey = index["entries"]["6b1a29d8-2594-47e1-9d2e-b6e07b16631f"];
 var decryptedKey = decrypt(entryKey, "password", {iv: index.iv});
 var decryptedEntry = decrypt(encryptedEntry, decryptedKey, {iv: index.iv});

 console.log("Decoded works? Jay == " + decode64("SmF5"));

 console.log("here", encryptedEntry, index.iv);
 console.log(decryptedKey);
 console.log(decryptedEntry);

 ////////////////////////

 $("#show-index-toml").text(indexTOML);
 $("#show-index-json").text(JSON.stringify(index));

 tryPassword("");



 function tryPassword(password) {
 $("#wall").hide();
 $("#main").show();
 }
 }
 */
