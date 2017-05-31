module ApplicationHelper
  attr_reader :chain, :key, :signer

  #Initialize Chain
  def chain
    Chain::Client.new()#access_token: "client:bfd44f9c6e7439e821ddede45b98fe7653fbb186bd58002674bc3fe3637361aa"
  end

  #Assign key to user
  def key
    self.chain.mock_hsm.keys.create
  end

  #Initialize signer
  def signer
    Chain::HSMSigner.new
  end

end