module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    doc_length =  document.to_s.length
    row = Math.sqrt(doc_length).round
    col = 0
    if row == Math.sqrt(doc_length).to_i
      col = row
    else
      col = (doc_length / row.round) + 1
    end
    doc = document.to_s.chars.to_a.each_slice(col).to_a
    doc = doc.shuffle(random: Random.new(key))
    doc.map! { |p| p.shuffle(random: Random.new(key)) }
    doc.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    ciphertext = ciphertext.to_s.chars.to_a
    doc_length =  ciphertext.length
    row = Math.sqrt(doc_length).round
    decipher_arr = (1..doc_length).to_a

    if row == Math.sqrt(doc_length).to_i
      col = row
    else
      col = (doc_length / row) + 1
    end
    decipher_arr =  decipher_arr.each_slice(col).to_a
    decipher_arr = decipher_arr.shuffle(random: Random.new(key))

    decipher_arr.map! { |p| p.shuffle(random: Random.new(key)) }

    decipher_arr = decipher_arr.flatten

    counter = 1
    plaintext = []
    decipher_arr.each do
      plaintext << ciphertext[decipher_arr.index(counter)]
      counter += 1
    end
    plaintext.join
  end
end
