# Insider Trading Info System
The Insider Trading Information System comprises a Web application built with React and a insider_trading System developed using Elixir Phoenix.

I have used quantum scheduler for the background job which will run every 1 minute to get the insider trading data.

### Setup Backend

- Run `mix setup` to install, setup dependencies and setup the database
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Setup Frontend App

1. Navigate to the project directory: `cd insider-trade-view & npm install & npm start`
4. Open your web browser and navigate to [http://localhost:3000]

## Insider trading

Insider trading involves trading in a public company's stock or other securities by someone with non-public, material information about the company.
Insider transactions are legal if the insider makes a trade and reports it to the Securities and Exchange Commission.

### Instructions
The idea is to create a process that that will extract the data from the **sec.gov** and **edgar** and analyse it to report inside trading.

The criteria to select the companies is up to you! You can find a list of public tickers in the links below.

The expected response will be the ticker/company, the person who did the transaction, job title, the date and the amount of shares and how much in percentage of the market cap that represents. 

For the MarketCap, you can use Yahoo Api or anyother you prefer.

*bonus*: 
- React UI to display the results
- Unit Tests
- Documentation

-----

### Publish your solution
- Fork this repository
- Create a new branch in your github
- Create a pull request to the main branch with your solution and send us the link

-----

#### Useful links:
- https://www.sec.gov/files/forms-3-4-5.pdf
- https://www.sec.gov/files/company_tickers_exchange.json
- https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=000879764&owner=include&count=100&output=atom
- https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=&company=&dateb=&owner=include&start=0&count=100&output=atom
- https://finance.yahoo.com/quote/AAPL?p=AAPL
- https://query1.finance.yahoo.com/v7/finance/quote?crumb=MY_CRUMB&symbols=AAPL&corsDomain=finance.yahoo.com
- https://github.com/ranaroussi/yfinance/blob/8975689bd19f96ea4655688611b0d853822eb5ec/yfinance/ticker.py
