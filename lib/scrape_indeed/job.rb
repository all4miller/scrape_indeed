class ScrapeIndeed::Job
  attr_accessor :company, :title, :location, :description, :url
  @@all = []

  def initialize(data_hash)
    data_hash.each { |k, v| self.send("#{k}=", v) }

    @@all << self
  end

  def self.all
    @@all
  end
end
