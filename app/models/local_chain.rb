require 'singleton'
class LocalChain < Chain::Client
  include Singleton
  def initialize
    super({access_token: "client:34ff6a19bbafec96c983aeeae56b84e56a06cd517634a2a55867d1c22e005f00"})
  end
end
