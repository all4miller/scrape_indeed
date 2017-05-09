# Controller
class ScrapeIndeed::CLI
  def call
    ScrapeIndeed::Graphic.display
    puts "Welcome to Scrape Indeed"
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

    # call scrape with above data
    puts "Scraping...one moment"
  end
end
