# CLI Controller 
class RemoteWomanScraper::CLI
    attr_accessor :scraper

    def call 
        welcome

        @scraper = RemoteWomanScraper::Scraper.new
        scrape

        search

        goodbye
    end

    def welcome 
        puts "Welcome to the Remote Woman Scraper Tool. Please follow the prompts..."
    end

    def goodbye
        puts "Thank you for using the Remote Woman Scraper Tool."
    end

    def scrape 
        @scraper.make_jobs
        RemoteWomanScraper::JobPost.all
    end

    def search
        loop do 
            new_search
            
            puts "Would you like to start a new search? (y/n)"
            input = gets.strip.downcase

            if input != "y"
                break
            end
        end
    end

    def new_search
        puts "Are you looking for full-time or part-time jobs? Enter 'f', 'p', or 'both'."
        schedule = gets.strip.downcase

        # puts "Please enter your search criterion separated by commas, e.g., 'full-stack, engineer, JavaScript'. Type 'all' to see all job posts."
        # search_criteria = gets.strip.downcase

        # list_jobs(schedule, search_criteria)
        list_jobs(schedule)
    end

    def list_jobs(schedule)
        jobs = find_by_schedule(schedule)
        #binding.pry

        if jobs == []
            puts "There were no jobs matching your preferred schedule."
        end

        @scraper.print_jobs(jobs)

        # if input == 'all'
        #     @scraper.print_jobs(jobs)
        # end
    end

    def find_by_schedule(schedule)
        jobs = []

        if schedule == 'f'
            jobs = RemoteWomanScraper::JobPost.all.select {|job| job.schedule == 'Full Time'}
        elsif schedule == 'p'
            jobs = RemoteWomanScraper::JobPost.all.select {|job| job.schedule == 'Part Time'}
        elsif schedule == 'both'
            jobs = RemoteWomanScraper::JobPost.all
        end

        jobs
    end

end