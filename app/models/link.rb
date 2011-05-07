require 'open-uri'

class Link < ActiveRecord::Base
  include SanitizeUrl
  
  scope :main_links, where(:working=>false)
  scope :working_links, where(:working=>true)

  belongs_to :user
  acts_as_list :scope => :user, :top_of_list => 0

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
