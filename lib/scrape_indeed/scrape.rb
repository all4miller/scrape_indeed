class ScrapeIndeed::Scrape
  def self.run(data)
    # Scrape with nokogiri here
    doc = Nokogiri::HTML(open(prep_url(data)))

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

  def self.prep_url(data)
    # Sample url
    # https://www.indeed.com/jobs?q=javascript+ruby&l=Duluth%2C+GA

    #No keywords
    #https://www.indeed.com/jobs?q=&l=Duluth%2C+GA

    # No city
    # https://www.indeed.com/jobs?q=javascript&l=GA

    # No state
    # https://www.indeed.com/jobs?q=javascript&l=Duluth


    base_url = "https://www.indeed.com/jobs?q="
    keywords = data[:keywords].join("+")
    location = "&l="
    city = data[:city]
    split = "%2C+"
    state = data[:state]

    query = ""

    if keywords.length > 0
      query = "#{keywords}"
    elsif !city.nil? && !state.nil?
      query += "#{location}#{city}#{split}#{state}"
    elsif !city.nil? && state.nil?
      query += "#{location}#{city}"
    elsif city.nil? && !state.nil?
      query += "#{location}#{state}"
    else
      query += "#{location}"
    end
    "#{base_url}#{query}"
  end
end
