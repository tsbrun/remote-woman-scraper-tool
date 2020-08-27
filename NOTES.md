1. Write the code you wish you had. 

2. The CLI controller is responsible for user interactions, like welcoming the user to the program and dealing with input.

3. Go one step at a time. Don't try to deal with a main problem of your program right at the beginning. Start with a stub, just to make sure things are working as they should.

4. The order in which you load your require and require_relative files matters. I was loading the CLI before the jobPost file. Since CLI is dependent on the jobPost file, it was not working. It came up with an "uninitialized constant RemoteDeveloperWoman::JobPost" error, even though I had clearly defined that class and loaded in the required files. They just weren't required in the right order.

5. If you define a class like so--class ModuleName::ClassName--then you have to use the same syntax when creating a new 
instance of that class. E.g., I created the class RemoteWomanScraper::JobPost. When I tried to run the following code ( job_post = JobPost.new ) it gave me the error "uninitialized constant RemoteWomanScraper::JobPost::JobPost". What I should have done was "job_post = RemoteWomanScraper::JobPost.new". If you use namespacing convention to define a class, you must use namespacing convention to instantiate an instance of that class.


What is the code I wish I had?
=> Scraper class scrapes the website and contains a list of all developer job posts.
=> Scraper class makes a job post instance out of each job post in that list.
=> Scraper class adds those job post instances to a class @@all variable.
=> I can call on Scraper.all and filter through it with something... 

=> The filter / search function may need another class. I'll focus on scraping the website first, though. 

6. Filter by schedule 

# cli prompts : "Looking for full-time or part-time or both?"
## get input 
## if full-time 
## search through all JobPosts and find instances where schedule == 'Full Time'
## if part-time
## search through all JobPosts and find instances where schedule == 'Part Time'
## if both
## basically, do nothing and proceed to the next prompt

# find_by_schedule(schedule)
## RemoteWomanScraper::JobPost.all {|job| job.schedule == schedule}

# input will be 'f', 'p', or 'both'...
# if 'f'
## find_by_schedule('Full Time')
# elsif 'p'
## find_by_schedule('Part Time')
# else
## break (???)
# end

Right now, my find_by_schedule feature technically works. However, it doesn't affect the results of the second prompt / input / whatever... 

cli: f, p , or both
***
user: f 
cli: all
=> Collect ONLY full-time jobs from JobPost.all
*** 
user: p
cli: all
=> Collect ONLY part-time jobs from JobPost.all

1. We need jobs to be created by Scraper before we run #find_by_schedule so there will be an array for it to filter through
    # scrape before running any lists or filters 
2. Why does #find_by_schedule return nil? 