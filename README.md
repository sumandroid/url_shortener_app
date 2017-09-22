# url_shortener
It's a Rails application which takes the url as an input and converts the url into a short url

Ruby version 2.3.1, but it will work on the lower versions as well as it does not has any dependencies.
Rails version 5.0.6, but it will work on the lower Rails versions as well.

I am using Mysql for my project hence I made following changes in my Gemfile
1. remove gem 'sqlite3' from your gemfile.
2. add gem 'mysql2' in your development group
3. To deploy your app on heroku add gem 'pg' in your production group as heroku only supports PostgreSql.
4. I am also using bootstrap, to use bootstrap in your app add gem 'bootstrap3-rails', '~> 3.2' to your gemfile but it's upto you it is not a dependency.

run bundle install

change the database.yml file:
1.change the adapter to mysql2 instead of sqlite3 if you are using the mysql
2.change the socket if you are connecting through the xampp or wampp, I am using Xampp.
3.In production change the adapter to postgresql.

