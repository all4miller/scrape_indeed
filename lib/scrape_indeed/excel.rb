class ScrapeIndeed::Excel
  def self.write(data)
    p = Axlsx::Package.new
    wb = p.workbook

    wb.add_worksheet(:name => "Jobs") do |sheet|
      sheet.add_row ["Company", "Job Title", "City", "Description"]

      data.each do |job|
        sheet.add_row [job[:name], job[:title], job[:city], job[:description]]
      end
    end
    p.serialize self.config_filename
  end

  def self.config_filename
    "#{Dir.home()}/Desktop/scraped-indeed-#{Date.today.to_s}.xlsx"
  end
end
