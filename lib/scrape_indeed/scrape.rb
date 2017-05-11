class ScrapeIndeed::Scrape
  attr_accessor :counter

  def initialize
    @counter = 1
  end

  def run(data)
    if @counter == 1
      doc = Nokogiri::HTML(open(prep_url(data)))
    else
      doc = Nokogiri::HTML(open("https://www.indeed.com/#{data}"))
    end

    jobs = doc.css("#resultsCol").css(".row")

    jobs.each do |job|
      details = {}
      details[:company] = job.css(".company").text.strip
      details[:title] = job.css(".jobtitle").text.strip
      details[:description] = job.css(".summary").text.strip
      details[:location] = job.css(".location").text.strip

      begin
        title_div = job.css(".jobtitle").css("a")
        url = title_div[0]["href"]
        details[:url] = "https://www.indeed.com#{url}"
      rescue
        details[:url] = ""
      end
      ScrapeIndeed::Job.new(details)
    end

    pages = doc.css(".pagination").css("a")
    next_element = pages.detect { |p| p.css(".pn").text == (@counter + 1).to_s }

    if next_element.nil?
      next_page = nil
    else
      next_page = next_element["href"]
    end

    @counter += 1
    run(next_page) if !next_page.nil?
  end

  def prep_url(data)
    base_url = "https://www.indeed.com/jobs?q="
    keywords = data[:keywords].join("+")
    location = "&l="
    city = data[:city]
    split = "%2C+"
    state = data[:state]

    query = ""

    if keywords.length > 0
      query = "#{keywords}"
    end

    if !city.nil? && !state.nil?
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
