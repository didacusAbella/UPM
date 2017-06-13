require 'singleton'
class LocalChain < Chain::Client
  include Singleton
  def initialize
    super({access_token: "client:9e0c8fffa0a7d14961af6146081c32c411450c6fc88c8faba1aacb6f64a4616c"})
  end
end
