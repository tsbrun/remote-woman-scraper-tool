# CLI Controller 
class RemoteWomanScraper::CLI

    def call 
        welcome
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
        scraper = RemoteWomanScraper::Scraper.new 
        scraper.make_jobs
        RemoteWomanScraper::JobPost.all
        # returns all instances of jobs
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

        #find_by_schedule(schedule)
        ## returns list of jobs filtered by schedule

        # list_jobs needs to act on return value of find_by_schedule

        puts "Please enter your search criterion separated by commas, e.g., 'full-stack, engineer, JavaScript'. Type 'all' to see all job posts."
        input = gets.strip.downcase

        list_jobs(schedule, input)
    end

    def find_by_schedule(input)
        jobs = []
        case input 
        when input == 'f'
            jobs = scrape.select {|job| job.schedule == 'Full Time'}
            binding.pry
        when input == 'p'
            jobs = scrape.select {|job| job.schedule == 'Part Time'}
        end
        jobs
    end
    #binding.pry

    def list_jobs(schedule, input)

        # we can call find_by_schedule within this method

        jobs = find_by_schedule(schedule)
        # we just need input to deal with this jobs variable, rather than directly with RemoteWomanScraper::JobPost.all

        # if input == "all"
        #     scraper = RemoteWomanScraper::Scraper.new
        #     scraper.print_jobs(jobs)
        #     # print_jobs needs to accept our jobs variable
        # end

        # given schedule == 'f' and input == 'all', jobs == all instances of full-time jobs 
        # Let's see what #list_jobs returns... nothing. Which means the return value of find_by_schedule is still nil. 
        # WHYYYYYYYYYY
    end

end