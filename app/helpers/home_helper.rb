module HomeHelper


  # call-seq:
  #   self.class.create_user(params) => User
  #
  # create a new user with +params+ supplied by client form
  # +params+ is an Hash of values
  def create_user(params)
    user = User.new({name: params[:name], last_name: params[:last_name], 
    username: params[:username], token: "client:b36165fb3c037bbc47d1e1496f9b19f89dc13c2da9c129a792f71655416e077e"})
    key = user.blockchain.mock_hsm.keys.create
    user.blockchain.accounts.create(
      alias: user.username,
      root_xpubs: [key.xpub],
      quorum: 1,
      tags: {
        name: user.name,
        last_name: user.last_name,
      })
    user
  end
end
