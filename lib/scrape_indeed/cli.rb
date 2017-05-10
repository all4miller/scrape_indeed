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
      scraping
      post_scrape
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

    ScrapeIndeed::Scrape.new.run(inputs)
  end

  def scraping
    puts "Scraping...one moment"
    ScrapeIndeed::Excel.write
    puts "Writing #{ScrapeIndeed::Job.all.length} results to file"
    puts "Done => #{ScrapeIndeed::Excel.config_filename}"
    puts "\n\n"
  end

  def post_scrape
    puts "What would you like to do next?"
    puts "Type:\n1 - Start another scrape\n2 - See scrape data in console"
    input2 = gets.strip

    if input2 == "1"
      start_menu
    elsif input2 == "2"
      detail_menu
    end
  end

  def detail_menu
    puts "Type:\nPrint - Print 10 results\nBack - Back to main menu\n"
    input =  gets.strip.downcase

    if input == "print"
      print_results(10)
      job_menu
    elsif input == "back"
      start_menu
    end
  end

  def job_menu
    puts "Type:\nLine \# - Print out a description\nBack - Back to detail menu"
    input = gets.strip.downcase

    if input == "back"
      detail_menu
    elsif /\A\d+\z/.match(input)
      print_detail(input)
      job_menu
    end
  end

  def print_results(qty)
    puts "Printing #{qty} results"
    ScrapeIndeed::Job.all.take(qty).each.with_index do |e,i|
      puts "#{i + 1}. #{e.title} @ #{e.company} in #{e.location}."
    end
  end

  def print_detail(input)
    item = ScrapeIndeed::Job.all[input.to_i - 1]
    puts "#{item.title} @ #{item.company} in #{item.location}, #{item.description}"
  end
end
