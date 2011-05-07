require 'open-uri'

class Link < ActiveRecord::Base
  include SanitizeUrl
  
  #  scope :main_links, where(:working=>false)
  #  scope :working_links, where(:working=>true)

  belongs_to :user

  before_save :clean_url, :if => Proc.new { |l| l.url_changed?}
  before_save :get_title, :if => Proc.new { |l| l.url_changed?}

  validate :validate_max_number_of_links

  def clean_url
    unless url.present?
      errors.add_to_base("Empty Url")
      return false
    end
    self.url = sanitize_url(self.url)
  end

  def get_title
    doc = Nokogiri::HTML(open(self.url))
    self.title = doc.at_css("title").text
  rescue
    errors.add_to_base("Wrong url")
    false
  end

  def validate_max_number_of_links
    if self.working?
      errors.add_to_base("You cannot have more than 30 working links.") unless self.user.working_links.count < 30
    else
      errors.add_to_base("You cannot have more than 10 main links.") unless self.user.main_links.count < 10
    end
  end
end
