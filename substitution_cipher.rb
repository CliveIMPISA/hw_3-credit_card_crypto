module SubstitutionCipher
  module Caeser
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caeser cipher
      document.to_s.chars.map{|p| (((p.ord - 32)+ key) %95 + 32).chr}.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caeser cipher
      document.to_s.chars.map{|p| (((p.ord - 32) - key) %95 + 32).chr}.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caeser cipher
      cipher = (0...128).to_a.map{|p| p.chr}
      a = cipher.shuffle(random: Random.new(key))
      document.to_s.chars.map{|p| a[cipher.index(p)]}.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caeser cipher
      cipher = (0...128).to_a.map{|p| p.chr}
      a = cipher.shuffle(random: Random.new(key))
      document.to_s.chars.map{|p| cipher[a.index(p)]}.join
    end
  end
end
