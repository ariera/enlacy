class Link < ActiveRecord::Base
  #require 'open-uri'

  belongs_to :user

  before_create :get_title


  def get_title
    doc = Nokogiri::HTML(open(self.url))
    self.title = doc.at_css("title").text
  end
end
