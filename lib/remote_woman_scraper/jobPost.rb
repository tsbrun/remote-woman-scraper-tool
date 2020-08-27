require 'pry'

class RemoteWomanScraper::JobPost
    attr_accessor :title, :schedule, :company, :about, :url

    @@all = []

    def initialize
        @@all << self 
    end

    def self.all 
        @@all
    end
end