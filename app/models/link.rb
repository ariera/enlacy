require 'open-uri'

class Link < ActiveRecord::Base
  include SanitizeUrl
  
  belongs_to :user

  before_save :clean_url, :if => Proc.new { |l| l.url_changed?}
  before_save :get_title, :if => Proc.new { |l| l.url_changed?}


  def clean_url
    self.url = sanitize_url(self.url)
  end

  def get_title
    doc = Nokogiri::HTML(open(self.url))
    self.title = doc.at_css("title").text
  end
end
