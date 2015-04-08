require_relative './luhn_validator.rb'
require 'json'
# Credit card Class
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator
  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :expiration_date, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above (do not forget the '@')
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json
    {
      # TODO: setup the hash with all instance vairables to serialize into json
      'number' => @number,
      'expiration_date' => @expiration_date,
      'owner' => @owner,
      'credit_network' => @credit_network
     }.to_json
  end

  # returns all card information as single string
  def to_s
    self.to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
   # TODO: deserializing a CreditCard object
    cc_object = JSON.parse(card_s)
    CreditCard.new(cc_Object['number'],cc_object['expiration_date'],cc_object['expiration_date'],cc_object['credit_network'])
  end

  def hash
    self.to_s.hash
  end

  def secure_hash
    sha256 = OpenSSL::Digest::SHA256.new
    digest = sha256.digest(self.to_s).unpack('h*')
  end
end
