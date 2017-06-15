require 'singleton'
class LocalChain < Chain::Client
  include Singleton
  def initialize
    super({access_token: "client:7ea651d325d8335b04942404e7c2435c4ba631eee7f3c03ab0258a18d415c35d"})
  end
end
