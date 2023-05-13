task :extract_script do
  require_relative "tools/rxdata"
  script_dir = "client/Scripts"
  script_data = "client/Data/Scripts.rxdata"
  if Dir.exist? script_dir
    puts "The directory output already exists. You will lose all changes in the directory. Do you want to overwrite it? (y/n)"
    return unless STDIN.gets.chomp.downcase == "y"
  end
  RXDATA.extract_script(script_dir, script_data)
  puts "Extracted script data."
end

task :compress_script do
  require_relative "tools/rxdata"
  script_dir = "client/Scripts"
  script_data = "client/Data/Scripts.rxdata"
  RXDATA.compress_script(script_dir, script_data)
  puts "Compressed script data."
end

task :test_play do
  Rake::Task[:compress_script].execute
  pid = Process.spawn("Game.exe", :chdir=>"client")
  Process.waitpid(pid)
end

task :install_githooks do
  File.write(".git/hooks/pre-commit", <<~HOOK
    #!/bin/sh
    # Check if there are changes in client/Scripts directory
    if git diff --cached --name-only --diff-filter=ACM | grep -q "^client/Scripts/"; then
        echo "Compressing client/Scripts directory"
        rake compress_script
    else
        echo "No changes in client/Scripts directory"
    fi
    exit 0
  HOOK
  )
  puts "Installed pre-commit hook."
end