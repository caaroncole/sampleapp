browser_input = "416  test".split('')

browser_input.each {|char| puts "Current character is: #{char}" }

sleep(0.5)

browser_input.each do |char| 
    puts "Character _#{char}_ is a number" if /\d/ === char
    puts "Character _#{char}_ is not a number" if /\D/ === char
    sleep(0.2)
end