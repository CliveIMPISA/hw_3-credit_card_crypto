require 'openssl'
require 'json'

module AesCipher
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use hexadecimal strings for output so that it is screen printable
    #       Use cipher block chaining mode only!
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    cipher.key = key
    iv = cipher.random_iv
    ciphertext = cipher.update(plaintext) + cipher.final
    output = [ iv.unpack("H*"),ciphertext.unpack("H*")]
    output.to_json
  end

  def self.encrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    decrypter = OpenSSL::Cipher::AES.new(128, :CBC)
    decrypter.decrypt
    decrypter.key = key
    decrypter.iv = JSON.parse(aes_crypt)[0].pack("H*")
    ciphertext = JSON.parse(aes_crypt)[1].pack("H*")
    plain = decrypter.update(ciphertext) + decrypter.final
  end
end