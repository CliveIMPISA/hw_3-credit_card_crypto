require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../aes_cipher'
require 'yaml'
require 'minitest/autorun'

password = YAML.load_file 'spec/test_passwords.yml'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
    @pt = 'Please encrypt this really important message! It is a secret'
    @key2 = 8
    @key3 = 'My secret Password'
  end

  describe 'Using Double Transposition Cipher' do
    it 'Should encrypt any text provided' do
      enc =  DoubleTranspositionCipher.encrypt(@pt, @key2)
      enc.wont_equal @pt.to_s
    end

    it 'Should return decrypted text' do
      enc =  DoubleTranspositionCipher.encrypt(@pt, @key2)
      dec =  DoubleTranspositionCipher.decrypt(enc, @key2)
      dec.must_equal @pt.to_s
    end

    it 'Should not decrypt because password was incorrect' do
      enc =  DoubleTranspositionCipher.encrypt(@pt, @key2)
      dec =  DoubleTranspositionCipher.decrypt(enc, 5)
      dec.wont_equal @pt.to_s
    end
  end

  password['valid'].each do |pass|
    describe 'Testing AES Cipher happy paths' do
      it 'Should encrypt any text provided' do
        enc = AesCipher.encrypt(@pt, pass)
        enc.wont_equal @pt.to_s
      end

      it 'Should return decrypted text' do
        enc = AesCipher.encrypt(@pt, pass)
        dec = AesCipher.decrypt(enc, pass)
        dec.must_equal @pt.to_s
      end
    end
  end

  password['invalid'].each do |pass|
    describe 'Testing AES sad paths' do
      it 'Should not decrypt because of incorrect password' do
        enc = AesCipher.encrypt(@pt, @key3)
        dec = AesCipher.decrypt(enc, pass)
        dec.wont_equal @pt.to_s
      end
    end
  end

  describe 'Using Caeser cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caeser.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caeser.encrypt(@cc, @key)
      dec = SubstitutionCipher::Caeser.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  # TODO: Add tests for double transposition and AES ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
end
