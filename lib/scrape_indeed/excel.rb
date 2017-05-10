class ScrapeIndeed::Excel
  def self.write
    p = Axlsx::Package.new
    wb = p.workbook

    wb.add_worksheet(:name => "Jobs") do |sheet|
      styles = wb.styles.add_style :b => true,
        :border => { :style => :thin, :color => "000000", :edges => [:bottom] }
      sheet.add_row ["Company", "Job Title", "Location", "Description", "URL"], :style => styles

      ScrapeIndeed::Job.all.each do |job|
        sheet.add_row [job.company, job.title, job.location, job.description, job.url]
      end
    end
    p.serialize self.config_filename
  end

  def self.config_filename
    "#{Dir.home()}/Desktop/scraped-indeed-#{SecureRandom.uuid}.xlsx"
  end
end
