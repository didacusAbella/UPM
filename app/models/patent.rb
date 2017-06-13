class Patent
  include Prawn::View
  attr_accessor :title, :background, :summary, :drawings, :claims, :description
  
  def initialize(opt, &block)
    @title = opt[:title]
    @background = opt[:background]
    @summary = opt[:summary]
    @drawings = opt[:drawings]
    @claims = opt[:claims]
    @description = opt[:description] 
    block.call(self) if block_given?
  end

  def save!(user, signature)
    user.assets.create(
      alias: title,
      root_xpubs: [user.key.xpub],
      quorum: 1,
      definition: {
        issuer: user.username,
        created_at: Time.now,
        integrity: signature
      },
      tags: {
        author: user.username,
        title: title
      }
    )
  end


  def to_pdf
    define_grid(columns: 1, rows: 1)
      grid(0, 0).bounding_box do
        font("Helvetica", :size => 30, :style => :bold) { text "PATENT LICENSE AGREEMENT", :align => :center }
        font("Helvetica", :size => 25, :style => :bold) { text "TITLE", :align => :center }
        font("Helvetica", :size => 20) {text title, :align => :center }
        font("Helvetica", :size => 25, :style => :bold) {text "BACKGROUND", :align => :center }
        text background, :align => :justify
        font("Helvetica", :size => 25, :style => :bold) { text "SUMMARY", :align => :center }
        text summary, :align => :justify
        font("Helvetica",:size => 25, :style => :bold) { text "CLAIMS", :align => :center }
        text claims, :align => :justify
        font("Helvetica", :size => 25, :style => :bold) {text "DESCRIPTION", :align => :center }
        text description, :align => :justify
        font("Helvetica", :size => 25, :style => :bold) {text "DRAWINGS", :align => :center }
        drawings.each do |file|
          image "#{File.absolute_path(file)}", fit: [bounds.width, bounds.height]
        end
    end
    save_as("contents/downloads/#{title}.pdf")
  end
end