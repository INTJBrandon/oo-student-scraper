  
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    student_page = Nokogiri::HTML(html)
    students = []
    student_page.css("div.student-card").each do |student|
    students_hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
    }
    students << students_hash
    end
    students 
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_profile = Nokogiri::HTML(html)
    student = {}
    #exitbinding.pry
    profiles = student_profile.css("div.social-icon-container a")
    profiles.each do |link|
      if link.attribute("href").value.include?("twitter")
      a = link.attribute("href").value
      student[:twitter] = a 
      elsif link.attribute("href").value.include?("linkedin")
        a = link.attribute("href").value
      student[:linkedin] = a 
      elsif link.attribute("href").value.include?("github")
        a = link.attribute("href").value
      student[:github] = a 
      else
        a = link.attribute("href").value
      student[:blog] = a 
      end
    end
    student[:profile_quote] = student_profile.css("div.profile-quote").text
    student[:bio] = student_profile.css("div.description-holder p").text
    student
  end

end

