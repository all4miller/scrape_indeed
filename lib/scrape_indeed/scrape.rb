class ScrapeIndeed::Scrape
  def self.run(data)
    # Mock Return Data:
    # [{
    #   :name => "Website Builders, Inc.",
    #   :title => "Javascripter",
    #   :city => "Atlanta",
    #   :description => "Experience to a modern web application framework such as Ruby on Rails, Spring MVC, and Node.js. Experience in a web front-end technology and framework such as..."
    # },
    # {
    #   :name => "Website Builders, Inc.",
    #   :title => "Javascripter",
    #   :city => "Atlanta",
    #   :description => "Experience to a modern web application framework such as Ruby on Rails, Spring MVC, and Node.js. Experience in a web front-end technology and framework such as..."
    # }]

    results = []
    doc = Nokogiri::HTML(open(prep_url(data)))
    # jobs = doc.css(".row .result")
    jobs_col = doc.css("#resultsCol")
    jobs = jobs_col.css(".row")

    jobs.each do |job|
      details = {}
      details[:name] = job.css(".company").css("span").text.strip
      details[:title] = job.css(".jobtitle").text.strip
      details[:city] = job.css(".location").css("span").text.strip
      details[:description] = job.css(".summary").text.strip

      binding.pry
      results << details
    end
    results
  end

  def self.prep_url(data)
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
