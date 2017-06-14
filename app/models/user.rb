#Model Class that handle User
require 'digest'

class User < Chain::Client

  attr_accessor :token, :name, :last_name, :password, :username
  attr_reader :patents

  def initialize(username)
    @patents = []
    token = assign_token(username)
    super({ access_token: token })
  end



  def save!(args, signer, &block)
    key = mock_hsm.keys.create
    signer.add_key(key, mock_hsm.signer_conn)
    new_account = accounts.create(
      alias: args[:username],
      root_xpubs: [key.xpub],
      quorum: 1,
      tags: {
        name: args[:name],
        last_name: args[:last_name],
        password: Digest::SHA2.hexdigest(args[:username] + "-" + args[:secret]),
        username: args[:username]
      })
    block.call(self, new_account) if block_given?
    return self
  end

  def find(args, &block)
    crypto_pass = Digest::SHA2.hexdigest(args["username"] + "-" + args["secret"])
    acc = accounts.query(filter: 'alias=$1 AND tags.password=$2', filter_params: [args["username"], crypto_pass]).first
    block.call(self, acc) if block_given?
    return self
  end

  def find_patents
    assets.query(
      filter: 'definition.issuer=$1 AND tags.author=$2', 
      filter_params: [username, username]
      ).each do |asset|
        patents << asset
      end
  end


  private
  def assign_token(username)
    user_token = LocalChain.instance.access_tokens.create({ id: username })
    LocalChain.instance.authorization_grants.create({
      guard_type: 'access_token',
      guard_data: { id: user_token.id },
      policy: 'client-readwrite'
    })
    user_token.token
  end


end