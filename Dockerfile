#Use the Ruby 2.6.6 base image
FROM ruby:2.6.6

# Set character encoding to UTF-8
ENV LANG C.UTF-8

# Update repositories and install necessary packages in a single instruction
RUN apt-get update && apt-get install -y \
    default-mysql-client \ 
    nodejs \    
    vim \     
    --no-install-recommends && \ 
    rm -rf /var/lib/apt/lists/*   

# Install inotify-tools
RUN apt-get update && apt-get install -y inotify-tools

#Copy the application code to /srv/app
COPY . /srv/app
WORKDIR /srv/app

# Install gems using Bundler
RUN bundle install

#Expose port 3000
EXPOSE  3000
CMD rm -f tmp/pids/server.pid && rails s -b '0.0.0.0'
