class ScrapeIndeed::Scrape
  def self.run(city, state, keywords)
    # Sample url
    # https://www.indeed.com/jobs?q=javascript+ruby&l=Duluth%2C+GA

    # Scrape with nokogiri here

    # Mock Return Data:
    [{
      :name => "Website Builders, Inc.",
      :title => "Javascripter",
      :city => "Atlanta",
      :description => "Experience to a modern web application framework such as Ruby on Rails, Spring MVC, and Node.js. Experience in a web front-end technology and framework such as..."
    },
    {
      :name => "Website Builders, Inc.",
      :title => "Javascripter",
      :city => "Atlanta",
      :description => "Experience to a modern web application framework such as Ruby on Rails, Spring MVC, and Node.js. Experience in a web front-end technology and framework such as..."
    }]
  end
end
