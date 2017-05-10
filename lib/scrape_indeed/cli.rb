class ScrapeIndeed::CLI
  def call
    ScrapeIndeed::Graphic.display
    puts "Welcome to Scrape Indeed".colorize(:light_cyan)
    start_menu
  end

  def start_menu
    puts "Type 'scrape' to get started"
    input = gets.strip.downcase

    if input == "scrape"
      config_search
    else
      start_menu
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
    puts "\n\n"
    puts "What would you like to do next?"
    puts "Type:\n1 - Start another scrape\n2 - Print data to console"
    input2 = gets.strip

    if input2 == "1"
      start_menu
    elsif input2 == "2"
      data_detail
    end
  end

  def data_detail
    puts "Printing first 5 results"
    # print some results
    puts "Type:\nMore - Print 5 more results\nBack - Back to main menu\n Line\# - Print out a description"
  end
end
