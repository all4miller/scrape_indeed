# Controller
class ScrapeIndeed::CLI
  def call
    ScrapeIndeed::Graphic.display
    puts "Welcome to Scrape Indeed".colorize(:light_cyan)
    puts "Type 'scrape' to get started"
    input = gets.strip.downcase

    if input == "scrape"
      config_search
    end
  end

  def config_search
    inputs = {:keywords => []}
    puts "Please enter a city:"
    inputs[:city] = gets.strip.downcase
    puts "Please enter a state:"
    inputs[:state] = gets.strip.downcase
    puts "Please enter keywords (comma or space separated)"
    keywords = gets.strip.downcase.split(/,\s*| /)
    keywords.each { |k| inputs[:keywords] << k }

    ScrapeIndeed::Scrape.run(inputs)
    puts "Scraping...one moment"
    ScrapeIndeed::Excel.write
    puts "Writing #{ScrapeIndeed::Job.all.length} results to file"
    puts "Done => #{ScrapeIndeed::Excel.config_filename}"
  end
end
