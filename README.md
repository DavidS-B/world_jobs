# World Jobs

## Installation

Install the dependencies of the project:

```elixir
mix deps.get
```

Compile the project:

```elixir
mix compile
```

Run tests:

```elixir
mix test
```

### Exercise 1

Start the `iex` session:

```elixir
iex -S mix
```

Then run this function:

```elixir
WorldJobs.collect_table
```

### Exercise 3

Start the application:

```elixir
mix run --no-halt
```

Then go to http://localhost:4000 to read the API doc.

Example: http://localhost:4000/lookup or http://localhost:4000/lookup/continent=Africa&profession=Tech

## Exercise 1: Continents grouping

For this exercise, I started to visualize the final expected output, then I chunked the exercise into several tasks:

1. Parse CSV files.
2. Get a continent with the given latitude and longitude coordinates.
3. Collect and gather information.

I had some issues with the first two tasks:

1. I started to implement the CSV parser. I found this [article](https://www.poeticoding.com/processing-large-csv-files-with-elixir-streams/) on poeticoding quite useful. It worked for the technical-test-professions.csv file, but not for the technical-test-jobs.csv file.
   So I finally decided to use [nimble_csv](https://github.com/dashbitco/nimble_csv), the most popular CSV librarie on [awesome-elixir](https://github.com/h4cc/awesome-elixir).

2. I started to look online for the resolution of this problem, and this [post](https://stackoverflow.com/questions/13905646/get-the-continent-given-the-latitude-and-longitude) on slack got my attention. The idea behind this post was to draw polygons of continents and determine in which polygon a latitude and longitude point was lying in. I finally decided not to use this post because I thought it would not be very accurate and that implementing a way to know if two points are in a polygon will be too long. Then I looked for useful geolocation libraries on [awesome-elixir](https://github.com/h4cc/awesome-elixir) and I tried three of them:

    . [geonames-elixir](https://github.com/pareeohnos/geonames-elixir) I used it to get a country code by latitude and longitude, and then the continent by country code. There were two main issues:

    - it was insanely slow.
    - it was limited to 1000 API calls by hour.

    . [wheretz](https://github.com/UA3MQJ/wheretz) This librarie resolved an issue encountered with the previous one: there were no calls to external services. However, there were still a few drawbacks:

    - it was also really slow.
    - a lot of unecessary dependencies were installed
    - each new session took almost 1 minute to start
    - I had to parse the final result to get the continent.

    So I investigated on how wheretz was working, and discovered that it was using the [topo](https://github.com/pkinney/topo) library to determine if two points are in a polygon. This resolved the issue of the slack overflow [post](https://stackoverflow.com/questions/13905646/get-the-continent-given-the-latitude-and-longitude) I mentionned. Therefore I decided to use it again.

    . [topo](https://github.com/pkinney/topo) To gain some time and because it was well done, I used the coordinates from the slack post and extended them a bit with this [site](https://www.keene.edu/campus/maps/tool/) to cover more surface. I decided to keep the division of the american continent by south and north as it was not specified in the exercise statement and I thought it could make sense to distinguich both location for jobs reasearch. Then I tested to retrieve all continents from the test-professions.csv file. It resulted in the fast expected behaviour. At the begining I ordered each continent by population, but when I had the final result of my developement I ordered them by number of jobs they had.

For the third task I just fetched the official [map documentation](https://hexdocs.pm/elixir/Map.html), and I used the [table_rex](https://github.com/djm/table_rex) librarie for the final output.

## Exercise 2: Question on Scalability

If we want the same output than the previous exercise, but with much more data comming in, I will parallelize the code by spawning several processes in the backgroud. Those processes will execute the same tasks but asynchronously so the whole operation will be faster to achieve.

We could also think about a vertical scaling by getting a more powerfull CPU and/or more RAM to the machine which executes the code, allowing processes to run faster and to have more of them running at the same time.

## Exercise 3: API implementation

To do the API implementation, I used two libraries:

. [plug_cowboy](https://github.com/elixir-plug/plug_cowboy) To implement my HTTP server.

. [poison](https://github.com/devinus/poison) To encode a map into the JSON format.

I added two filters to my API _/lookup_ endpoint:

. continent -> to look for a specific continent.

. profession -> to look for a specific profession.
