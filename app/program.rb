require 'readline'
require_relative 'dotenv'
require_relative 'helper'
require_relative 'models/robot'
require_relative 'models/table'

class Program
  attr_accessor :cmd_histories, :debug_mode
  attr_reader :command_files_dir

  def initialize(debug_mode: false)
    @debug_mode = debug_mode
    @cmd_histories = []
    @command_files_dir = 'app/factories/robot_commands'
  end

  def self.call(debug_mode: false)
    program = new(debug_mode: debug_mode)
    robot = Robot.new
    table = Table.new(5, 5)

    puts_robot_ascii
    puts "Robot Challenge has started!"
    puts "You can type your commands here, e.g. PLACE X,Y,[NSEW], MOVE, LEFT, RIGHT, REPORT"
    puts "Enter 'h' / 'help' for list of commands"

    loop do
      begin
        # Read input using Readline which will support Up/Down arrow key
        input = Readline.readline("Enter command: ", true) # 'true' enables history
        input.upcase!

        # Exit condition if the user types 'EXIT'
        break if input.nil? || input.upcase == 'EXIT'

        program.execute_command(input, robot, table)

        robot.report if program.debug_mode

        # Add the input to history
        program.cmd_histories << input
        program.cmd_histories = program.cmd_histories.last([ENV['HISTORY_LIMIT'].to_i, 5].max)
      rescue => e # Not using StandardError for now
        if program.debug_mode
          puts "\e[31mAn error occurred: #{e.message}.\n\e[0m"
          puts "\e[31m#{e.backtrace.join("\n")}\e[0m"
        else
          puts "\e[31mSomething went wrong! Please contact sysops or devs!\e[0m"
        end
      end
    end

    puts 'Robot Challenge has ended! See you soon!'
  end

  def execute_command(command, robot, table)
    place_cmd = /^PLACE (\d+),(\d+),([NSEW]|NORTH|SOUTH|EAST|WEST)$/i

    if %w(HELP H).include?(command.upcase)
      puts_help_menu
      return
    end

    if robot.base.nil? && place_cmd.match(command.upcase).nil?
      puts "Invalid command! Please use 'PLACE' command first"
      return
    end

    case command.upcase
    when place_cmd
      x, y, direction = $1.to_i, $2.to_i, convert_direction_to_degree($3[0])
      robot.place(x, y, direction, table)
    when 'MOVE'
      robot.move
    when 'LEFT'
      robot.rotate(-90)
    when 'RIGHT'
      robot.rotate(90)
    when 'REPORT'
      robot.report
    when 'HISTORY'
      puts 'Command History:'
      @cmd_histories.each_with_index { |cmd, idx| puts "#{idx + 1}: #{cmd}" }
      return
    when 'ROBOT' # hidden command
      file_path = select_command_file
      execute_from_file(file_path, robot, table) if file_path
      return
    else
      puts "Invalid command! Enter 'h' / 'help' for list of commands"
    end
  end

  def list_files
    # Get all .txt files from the directory
    Dir.glob(File.join(@command_files_dir, '*.txt'))
  end

  def select_command_file
    files = list_files

    if files.empty?
      puts 'No command files found!'
      return nil
    end

    # List files for the user to choose from
    files.each_with_index do |file, index|
      puts "#{index + 1}: #{File.basename(file)}"
    end

    # Ask user to select a file by number
    print 'Please select a command file by number: '
    selected_index = gets.chomp.to_i - 1

    if selected_index >= 0 && selected_index < files.length
      selected_file = files[selected_index]
      puts "You selected: #{File.basename(selected_file)}"
      return selected_file
    else
      puts 'Invalid selection!'
      return nil
    end
  end

  def execute_from_file(file_path, robot, table)
    unless file_path
      puts 'No such file'
      return
    end

    # Read and execute the commands from the selected file
    File.readlines(file_path).each do |line|
      line.strip!
      next if line.empty? || line.start_with?('#')  # Ignore comments and empty lines
      puts "Executing: #{line}"
      execute_command(line, robot, table)
    end
  end

end

# Start the program
Program.call(debug_mode: ENV['DEBUG'].to_i > 0)
