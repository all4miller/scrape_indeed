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
    puts "Please enter a city:"
    city = gets.strip.downcase
    puts "Please enter a state:"
    state = gets.strip.downcase
    puts "Please enter keywords (comma or space separated)"
    keywords = gets.strip.downcase

    data = ScrapeIndeed::Scrape.run(city, state, keywords)
    puts "Scraping...one moment"
    ScrapeIndeed::Excel.write(data)
    puts "Writing to file"
    puts "Done"
  end
end
