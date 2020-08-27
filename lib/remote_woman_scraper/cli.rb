# CLI Controller 
class RemoteWomanScraper::CLI

    def call 
        welcome
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
        scraper = RemoteWomanScraper::Scraper.new 
        scraper.make_jobs
        RemoteWomanScraper::JobPost.all
        # returns all instances of jobs
        # this is working 
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

        puts "Please enter your search criterion separated by commas, e.g., 'full-stack, engineer, JavaScript'. Type 'all' to see all job posts."
        search_criteria = gets.strip.downcase

        list_jobs(schedule, search_criteria)
        # needs to use 'schedule' to get only part/full-time jobs
    end

    def find_by_schedule(schedule)
        jobs = []
        case schedule 
        when schedule == 'f'
            jobs = RemoteWomanScraper::JobPost.all.select {|job| job.schedule == 'Full Time'}
        when schedule == 'p'
            jobs = RemoteWomanScraper::JobPost.all.select {|job| job.schedule == 'Part Time'}
        end
        jobs
    end
    binding.pry

    def list_jobs(schedule, input)
        jobs = find_by_schedule(schedule)
        binding.pry

        if input == 'all'
            jobs
        end
    end

    # def list_jobs(schedule, input)

    #     # we can call find_by_schedule within this method

    #     jobs = find_by_schedule(schedule)
    #     # we just need input to deal with this jobs variable, rather than directly with RemoteWomanScraper::JobPost.all

    #     # if input == "all"
    #     #     scraper = RemoteWomanScraper::Scraper.new
    #     #     scraper.print_jobs(jobs)
    #     #     # print_jobs needs to accept our jobs variable
    #     # end

    #     # given schedule == 'f' and input == 'all', jobs == all instances of full-time jobs 
    #     # Let's see what #list_jobs returns... nothing. Which means the return value of find_by_schedule is still nil. 
    #     # WHYYYYYYYYYY

    #     # I'm pretty sure the problem is with the scraper.
    # end
    #binding.pry

end