# Simple dotenv code from the internet (CHATGPT)
# To avoid installing new gem for just simple use case

# Method to load environment variables from .env file
def load_dotenv(file_path)
  return unless File.exists?(file_path)

  File.readlines(file_path).each do |line|
    line.strip!

    # Ignore comments and empty lines
    next if line.empty? || line.start_with?('#')

    # Split by '=' to get the key-value pair
    key, value = line.split('=', 2)

    # Set the environment variable (to be used in ENV)
    ENV[key.strip] = value.strip if key && value
  end
end

# Load the .env file from the root directory (absolute path)
load_dotenv(File.expand_path('../.env', __dir__))
