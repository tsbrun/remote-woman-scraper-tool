require 'nokogiri'
require 'open-uri'
require 'pry'

require "/Users/work/Documents/Flatiron/code/cli_project/remote_woman_scraper/lib/remote_woman_scraper.rb"

class RemoteWomanScraper::Scraper 

    def get_page
        Nokogiri::HTML(open("https://remotewoman.com/remote-developer-jobs/"))
    end

    def get_jobs
        job_urls = []
        self.get_page.css("ul.job_listings a.job_listing-clickbox").each {|a| job_urls << a["href"]}
        job_urls[0..4]
        # get_jobs returns urls in String form
    end

    def make_jobs
        self.get_jobs.each do |url|
            job = RemoteWomanScraper::JobPost.new
            job.url = url 
            job.title = Nokogiri::HTML(open(url)).css("h1.page-title").text.strip
            job.schedule = Nokogiri::HTML(open(url)).css("ul.job-listing-meta.meta").css("li.job-type").text.strip
            job.company = Nokogiri::HTML(open(url)).css("ul.job-listing-meta.meta").css("li.job-company").text.strip
            job.about = Nokogiri::HTML(open(url)).css("p").first.text.strip
        end
    end

    def print_jobs(jobs)
        self.make_jobs

        jobs.each.with_index(1) do |job, i|
            if job.title && job.title != ""
                puts "\n"
                puts "#{i}. #{job.title} | #{job.schedule} | #{job.company}"
                puts "\n"
                puts "#{job.about}"
                puts "\n"
                puts "Click here for more information: #{job.url}"
                # find a way to make the url a clickable link
                puts "\n"
            end
        end
    end

end