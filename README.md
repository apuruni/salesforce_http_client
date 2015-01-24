# SalesforceHttpClient

This gem provides a simple way to download report data from salesforce.com.
It works well with any ruby applications, include such as Ruby on Rails.

You can access salesfore.com using only your sales force login id (=email) and password. 
A security token is no need.

## Installation

Add this line to your application's Gemfile:

    gem 'salesforce_http_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install salesforce_http_client

## Configuring SalesforceHttpClient

Add configurations to set your salesforce.com login_id/password.

```ruby
SalesforceHttpClient.configure do |config|
  config.salesforce_login_id = 'my_login_id_or_email'
  config.salesforce_password = 'my_password'
end
```

If you're using Rails, create an initializer for this:

    config/initializers/salesforce_http_client.rb

## Downloading report from salesforce.com

First, you need find the salesforce ID for your report.
For example:  http://na1.salesforce.com/000000000000ABC, where '000000000000ABC' is the salesforce ID.

Then, pass the salesforce ID and a file path to  SalesforceHttpClient::Client#download_report(salesforce_id, report_save_path) method.

```ruby
salesforce_id = '000000000000ABC'
report_save_path = "tmp/#{salesforce_id}.csv"

sf_client = SalesforceHttpClient::Client.new
sf_client.download_report(salesforce_id, report_save_path)
```

After a few seconds, you will find your report data(csv format) at report_save_path.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/salesforce_http_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
