class User
  attr_reader :username, :blockchain
  attr_accessor :name, :last_name, :token

  def initialize(opt={})
    @name = opt[:name]
    @last_name = opt[:last_name]
    @username = opt[:username]
    @token = opt[:token]
    @blockchain ||= Chain::Client.new(access_token: @token)
  end

  def not_valid_token?
    token.nil?
  end

  private
end