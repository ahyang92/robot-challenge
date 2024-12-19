# Use the official Ruby 3.0 image from Docker Hub
FROM ruby:3.0

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of your app's files into the container
COPY . .

# command to run Ruby app
CMD ["ruby", "app/program.rb"]
