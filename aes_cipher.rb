require 'openssl'
require 'json'

module AesCipher
  def self.encrypt(document, key)
    begin
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.encrypt
      cipher.key = key.to_s
      iv = cipher.random_iv
      ciphertext = cipher.update(document) + cipher.final
      output = [ iv.unpack("H*"),ciphertext.unpack("H*")]
    rescue
      "Passphrase too short! Should be at least 16 characters long"
    else
      output.to_json
    end
  end

  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    begin
      decrypter = OpenSSL::Cipher::AES.new(128, :CBC)
      decrypter.decrypt
      decrypter.key = key.to_s
      decrypter.iv = JSON.parse(aes_crypt)[0].pack("H*")
      ciphertext = JSON.parse(aes_crypt)[1].pack("H*")
      plain = decrypter.update(ciphertext) + decrypter.final
    rescue
      "Error! Incorrect PassPhrase Enter. Please Try Again"
    else
      plain
    end
  end
end
