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
    wb = Excel.new("text.xls")
    f = Format.new
    f.color = "green"
    f.bold = true

    ws = wb.add_worksheet
    ws.write(0,0, "Hello", f)

    wb.close
  end
end
