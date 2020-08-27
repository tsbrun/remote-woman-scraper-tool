# CLI Controller 
class RemoteWomanScraper::CLI

    def call 
        welcome
        search
        goodbye
    end

    def welcome 
        puts "Welcome to the Remote Woman Scraper Tool. Please follow the prompts..."
        sleep 1
    end

    def goodbye
        puts "Thank you for using the Remote Woman Scraper Tool."
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

        find_by_schedule(schedule)

        puts "Please enter your search criterion separated by commas, e.g., 'full-stack, engineer, JavaScript'. Type 'all' to see all job posts."
        input = gets.strip.downcase

        list_jobs(input)
    end

    def find_by_schedule(input)
        case input 
        when input == 'f'
            RemoteWomanScraper::JobPost.all.select {|job| job.schedule == 'Full Time'}
        when input == 'p'
            RemoteWomanScraper::JobPost.all.select {|job| job.schedule == 'Part Time'}
        end
    end
    binding.pry

    def list_jobs(input)

        if input == "all"
            scraper = RemoteWomanScraper::Scraper.new
            scraper.print_jobs
        end
    end

end