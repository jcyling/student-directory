@students = [] # an empty array accessible to all methods

def add_to_student_list(name)
  @students << {name: name, cohort: :november}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_to_student_list(name)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def load_students(filename = "students.csv")
  File.open(filename).each do |line|
      name, cohort = line.chomp.split(",")
      add_to_student_list(name)
  end

  puts "Students loaded."
end

def locate_students_file
  puts "What's the filename?"

  filename = gets.chomp

  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def save_students
  puts "What's the filename?"
  filename = gets.chomp
  # open the file for writing
  File.open(filename, "w") do |file|
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file.write(student_data.join(",") + "\n")
    end
  end

  puts "Students saved."
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    locate_students_file
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

interactive_menu
