require 'digest'

module PatentHelper
 # call-seq:
  #   self.create_patent(params, *args) => Patent
  # This method create a new patent for a specific user and register it on the blockchain
  def create_patent(params, *args)
    #Create images from form submitted
    images = args.collect do |arg|
      File.open("contents/uploads/" + arg[:filename], "w") do |file|
       file.write(arg[:tempfile].read)
       file
      end
    end
    #Create an return patent object and pdf generation
    Patent.new(
      title: params[:title], 
      background: params[:background], 
      claims: params[:claims],
      summary: params[:summary], 
      description: params[:description],
      drawings: images
      ) do |created_patent|
        created_patent.to_pdf
        md5 = Digest::MD5.file "contents/downloads/#{created_patent.title}.pdf"
        created_patent.save!(self.class.current_user, self.class::SIGNER, md5.hexdigest)
        created_patent
    end
  end

  def deposit_patent(id)
    #Find Asset and Accounts
    ass = self.class.current_user.assets.query(
      filter: "alias=$1",
      filter_params: [id]
      ).first
    acc = self.class.current_user.accounts.query(
      filter: "alias=$1",
      filter_params: [self.class.current_user.username]
    ).first
    #Add Sign into HSMS
    self.class::SIGNER.add_key(ass.keys[0].root_xpub, self.class.current_user.mock_hsm.signer_conn)
    self.class::SIGNER.add_key(acc.keys[0].root_xpub, self.class.current_user.mock_hsm.signer_conn)
    #Start Transactions
    issuance = self.class.current_user.transactions.build do |b|
    b.issue asset_alias: id, amount: 1
    b.control_with_account account_alias: self.class.current_user.username, asset_alias: id, amount: 1
    end
    signed_issuance = self.class::SIGNER.sign(issuance)
    self.class.current_user.transactions.submit(signed_issuance)
    self.class.current_user.assets.update_tags(
      alias: id,
      tags: {
        deposited: true
      }
    )
  end

  def search_patents(name)
    self.class.current_user.transactions.query.select do |txt| 
      !txt.inputs[0].asset_alias.nil? && txt.inputs[0].asset_alias.include?(name)
    end
  end
end