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
    issuance = self.class.current_user.transactions.build do |b|
    b.issue asset_alias: id, amount: 1
    b.control_with_account account_alias: self.class.current_user.username, asset_alias: id, amount: 1
  end
  signed_issuance = self.class::SIGNER.sign(issuance)
  self.class.current_user.transactions.submit(signed_issuance)
  self.class.user.assets.query(
    filter: "alias=$1",
    filter_params: [id]
  ).first.update_tags(deposited: true)
  end
end