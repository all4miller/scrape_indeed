# Mock ARGS
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

class ScrapeIndeed::Excel
  include Spreadsheet

  def self.write(data)
    wb = Excel.new(self.config_filename)
    ws = wb.add_worksheet

    # Setup Column Headings
    ws.write(0, 0, "Company")
    ws.write(0, 1, "Job Title")
    ws.write(0, 2, "City")
    ws.write(0, 3, "Description")

    data.each.with_index do |job, i|
      # index + 1 will be row
      # hard code column numbers
      ws.write(i + 1, 0, job[:name])
      ws.write(i + 1, 1, job[:title])
      ws.write(i + 1, 2, job[:city])
      ws.write(i + 1, 3, job[:description])
    end

    wb.close
  end

  def self.config_filename
    "#{Dir.home()}/Desktop/scraped-indeed-#{Date.today.to_s}.xls"
  end
end
