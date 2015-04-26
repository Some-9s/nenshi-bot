# Nenshi_bot

## A Robotic Mayor?

Nenshibot is Calgary's robotic mayor. Using [Calgary's very own open data](https://data.calgary.ca/opendata/Pages/DatasetListingAlphabetical.aspx), Nenshibot will help the citizen of Calgary connect and use Open data in a friendly and interactive way.
It's purpose is to alleviate 311 calls, allow Calgarians with the ability to easily interact with Calgary's Open dataset, and have fun doing it!

## Usage

    Nenshi_bot > nenshi_bot help
    Nenshi_bot: help - Lists help information for terms and command the robot will respond to.
    Nenshi_bot: help COMMAND - Lists help information for terms or commands that begin with COMMAND.
    Nenshi_bot: info - Replies with the current version of Lita.
    Nenshi_bot: users find SEARCH_TERM - Find a Lita user by ID, name, or mention name.
    Run - Let's go for a jog
    Golf - What's the best golf course?
    Garbage - Help, I need a landfill
    Nenshi_bot: image QUERY - Displays a random image from Google Images matching the query.
    on fire - You need advice on this?
    fire station(s) around ADDRESS - Returns fire stations near ADDRESS.
    fire station(s) near me - Returns fire stations around your location.
    Map all stations - Returns link to map of all fire stations.
    What station offers SERVICE? - Returns list of stations that offer SERVICE.
    How about a selfie? - My own personal collection
    What is the traffic like at LOCATION? - Displays the traffic status of LOCATION
    What is the traffic like near me? - Displays the traffic status near by
    Where are all of the traffic cams? - Displays a map of the available traffic cams


Using Twitter, you can tweet to @Nenshi_bot and Nenshibot will respond with a reply!

Example tweet

    @Nenshi_bot what is the traffic like on the deerfoot?

His response will be a tweet back with the current traffic status on the deerfoot.


# Under the hood

Nenshibot is a project based off of [Lita](https://www.lita.io/). A ruby based chat robot.

* Lita - A Chat robot written in ruby
* Twitter - Tweet, Tweet
* Google Big Query - A cloud based datastore
* [Calgary Open data](https://data.calgary.ca/opendata/Pages/DatasetListingAlphabetical.aspx) - Calgary's very own open data!

# Development environment

Developing for Nenshibot is almost identical to developing for Lita.

This repository provides Lita users with a complete development environment for trying out Lita and developing Lita plugins.

## Pre-requisites

* Create a twitter account and twitter api key
* We'll need open data stored in a query-able way, we are using Google Big query

Copy the `config.yml.template` to `config.yml` and change the keys for twitter api and google big query.

## Quick start

If you are already familiar with Vagrant and have it installed, just run the usual `vagrant up` and `vagrant ssh` commands.

## Documentation

For complete documentation on installing and using the development environment, please visit [Installation](http://docs.lita.io/getting-started/installation/) on the Lita documentation site.

## License

[MIT](http://opensource.org/licenses/MIT)
