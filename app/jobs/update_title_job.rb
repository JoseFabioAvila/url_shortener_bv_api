class UpdateTitleJob < ApplicationJob
  include HTTParty
  include ActiveRecord

  queue_as :default

  def perform(short_url)
    response = HTTParty.get(short_url.full_url)
    html = Nokogiri::HTML.parse(response.body)
    short_url.update(title: html.title)
  rescue ActiveRecord::RecordNotFound => e
    puts e
  end
end
