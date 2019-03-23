# Ambassador Coding Challenge

The API landing page can be found [here](https://ambassador-code-rails.herokuapp.com/api/v1) to see functional endpoints. This may take up to 30 seconds initially if Heroku needs to spin up a dyno.

This is a basic API to serve up data to a website that can track referrals. It has basic CRUD functionality, and can also track visits to a page. It has access to all links, one link, create link, and delete link. When the front end hits the main index '/' it should send a GET request to '/api/v1/links' to get back all links in JSON format to display on the page. This includes click counts. 

When a user enters in text into the text box to create a new link the site should send a POST request to '/api/v1/links?link={link_title}' which will return the object if successful, or return a 404 with an error if it didn't work, most likely due to the title not being unique. They can then either display this onto the end of the list, or make another GET request for all links.

When someone clicks on a referral link and gets directed to '{url}/spartans' or whatever the title is, the site should make a GET request to '/api/v1/links/spartans' before redirecting to '{url}/landing?link=spartans'. This will return JSON with the link title and also increment the counter by one. 

To delete a link the site should send a DELETE request to '/api/v1/links/spartans'. The deleted object will be returned on a successful delete, or a 404 and error will be returned if the delete didn't work. All clicks associated with that endpoint will be deleted.


## Problem & Solution

Tim Berners-Lee just created the internet. But what is the internet you say? More people need to find out. Instead of basic advertising I decided to help Tim out with referral marketing. Referral marketing has been shown to have more long term loyal customers along with higher short term spending compared to standard advertising, which means Tim is going to be one happy customer. 

To help my good friend get the word out on his awesome new invention I decided to build a referral marketing system for him for free. It's a very basic referral marketing system that can keep track of links, add links, delete links, and find out how many people have clicked on a link.

This system will have a back end and a front end. I decided to build the back end API to give easy access for a single page app. By using RESTful endpoints and CRUD functionality it will be easy to integrate with a front end. It also follows the [unofficial json spec](https://jsonapi.org/) to make things easy on the front end developer. 

It includes a basic API launchoff page for people to read that can be found [here](https://ambassador-code-rails.herokuapp.com/api/v1) so that anybody can use it. Future iterations may include security using JSON web tokens, however given the simplicity of the site that seems beyond the current scope. To keep track of clicks the data base uses a Links table and a Clicks table with a foreign ID for a link. This is to ensure that all clicks can be timestamped, and so that any future information, such as IP address, could be added on future iterations if required.

## Solution Focus

The tl;dr of the above is that this is a back-end focused solution since I'm applying for a back end position and I would like to spend time trying to build out a solution in Django also (haven't used it before) rather than work on a front end.

## Technical Choices and Tradeoffs

I wanted to keep it RESTful and use API versioning in case a later iteration comes out, so keeping endpoints at '/api/v1/links made sense. I also wanted to keep the use of :slugs in the API since I hadn't implimented them before and it seemed like a fun challenge. 

It uses a PostgreSQL database since it integrates easily with Heroku. I decided to go with a schema as follows:

### Links
| ID | Link | Slug | Created_at | Updated_at |
| --- | ---- | ---- | ---------- | ---------- |
| 1 | eagle | eagle | 3-23-19 | 3-23-19 |

### Clicks
| ID | Link_id | Created_at | Updated_at |
| --- | --- | --- | --- |
| 1 | 1 | 3-23-19 | 3-23-19 |
| 2 | 1 | 3-23-19 | 3-23-19 |


For table choice I was originally thinking it could make sense to keep click count in the Links table, but I wanted clicks to be trackable throughout time. It also gives freedom in case additional future info should be logged with each click, something that isn't possible with a simple counter in the Links table. Speed could eventually become an issue with this format since it has to count up clicks with a link's foreign ID, but it shouldn't be a problem for a while. Eventually an additional clicks column could be added on to Links if speed becomes an issue, but keep tracking them in the Clicks table also.

As for the Links table I would remove the slug column and just use :link instead of slug if I were to do this again, or I'd at least propose that to the team if it were on a real project. I know :slug is the appropriate way to make what's happening clear but having two columns in the table that are never different doesn't seem DRY. 

## Deployed 

[On Heroku found here.](https://ambassador-code-rails.herokuapp.com/api/v1)

## Other Projects

Highlighted projects can be found pinned on my GitHub, but here are a few cool ones I especially like.

[FiveCast](https://github.com/jpclark6/sweater-weather-fe) / [Sweater Weather](https://github.com/jpclark6/sweater-weather) - Deployed: [FiveCast](https://sweater-weather-1810.surge.sh/)/[Sweater Weater](https://sweater-weather-1810.herokuapp.com/api/v1/forecast?location=denver,co) This is a weather app I made to display weather forecasts for a city/state. This was the first project I did that creates a back and and front end on different servers. The back end is hosted on Heroku, and I used Surge for the single page front end. It was a solo project that I wrote all the code for, minus the basic framework. 

Back end - I really enjoyed the back end since it uses APIs from DarkSky for weather, Flickr for images of the city, and Google Geocoding API to convert a city/state combo into a latitude and longitude required from the other two APIs. There is a lot of moving parts behind the scenes to display the weather forecast and it was a ton of fun and really cool to get everything to mesh up and work as expected. It also gave me some good experience using external APIs and now I feel like I truley have the world at my fingertips given how many really cool APIs are out there, such as the [NASA API](https://api.nasa.gov/), [NREL API](https://developer.nrel.gov/), or [Cat As A Service API](https://cataas.com/#/).

Front end - Since I'm a back end developer I thought the front end I made in vanilla javascript looks pretty awesome, and it's also mobile responsive. Unfortunately back end APIs aren't that exciting to look at so it was fun to make a visually appealing front end to show off. Showing friends your 'super cool site' you made and then showing them some JSON text just doens't have the desired effect.

[I Wet My Plants GitHub](https://github.com/jpclark6/i-wet-my-plants) and [deplyed](https://i-wet-my-plants.herokuapp.com/) - This project was created with 4 other people and was a lot of fun to work on. I worked on a lot of various parts of it on my own and through pair programming. It's an app to help you to remember to water your plants. Some fun parts were that it uses Facebook OAuth (paired to create this), it tweets at you from a twitter account when it's time to water your plants (I did this part solo), and I also did a bit of styling on the site. The thing I was most excited about though was the back end API I build to integrate with hardware. A description can be found [here](http://i-wet-my-plants.herokuapp.com/api/v1). It allows a user to enter their hardware key in some theoretical watering hardware that can connect to the internet, and then the site will return whether your plants need watering. The hardware can then automatically water your plants and then send a POST back to the site telling it they're watered. It handrolls basic web tokens for a very secure watering system. By using text and keys created with that text it can keep track of whether POST requests to water are valid without keeping any information in the database about when it sent out keys to water and how long those keys are valid. I'd love to spend some time getting a fully functioning hardware sprinkler working once I'm out of school using Arduino. Maybe my houseplants won't die anymore (who am I kidding, I switched to industructable succulents long ago).

[LEData](https://github.com/jpclark6/LEData) - This isn't a web app, but I was still very excited when I got it to work. It uses 2 Arduinos to send data using only an LED light and then a photo sensor. I took a video [here](https://youtu.be/fEUkzCr64Jk). The speeds are relatively slow in today's world at about 4 kbps but it's limited by the ADC in the Arduino. What I like about this project was it required me to design a custom protocol to send data since there isn't a clock signal. It is designed so that any clock signal can work as long as it doesn't timeout. So whether you send data with a clock length of 50 us or 200 ms it will still work. It also integrates a small LED screen to display the text. Overall it's nothing hugely spectacular, but it's a ton of fun to say "I did this from scratch and it works" when it's a fairly unique contraption and took some thought to get it to work.