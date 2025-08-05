# Warcry-Tracker

A small Sinatra web application to help track fighters during a Warcry game. It keeps track of hit points, activation status each round and any items or treasures a fighter carries.

## Setup

Install dependencies with Bundler:

```bash
bundle install
```

## Running

Start the web server:

```bash
ruby app.rb
```

Then open [http://localhost:4567](http://localhost:4567) in your web browser.

## Features

- Add fighters with a starting amount of HP
- Damage or heal fighters
- Mark fighters as activated or deactivate them
- Start a new round to reset activations
- Give or take items from fighters

The previous command line script `warcry_tracker.rb` is still included if you prefer running in the terminal.
