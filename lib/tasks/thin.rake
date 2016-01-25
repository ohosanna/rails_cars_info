namespace :thin do
  namespace :cluster do
  desc 'Start thin cluster'
    task :start => :environment do
      Dir.chdir(Rails.root)
      port_range = Rails.env == 'development' ? 3 : 8
      (ENV['SIZE'] ? ENV['SIZE'].to_i : 4).times do |i|
        Thread.new do
          `sleep 1`
          port = ENV['PORT'] ? ENV['PORT'].to_i + i : ("#{port_range}%03d" % i)
          str  = "thin start -d -p#{port} -Ptmp/pids/thin-#{port}.pid"
          str += " -e#{Rails.env}"
          #puts "Running #{str} \n"
          puts "Starting server on port #{port}... \n"
          `#{str}`
        end
      end
    end
desc 'Stop all thin clusters'
    task :stop => :environment do
      Dir.chdir(Rails.root)
      Dir.new("#{Rails.root}/tmp/pids").each do |file|
        Thread.new do
          `sleep 1`
          if file.starts_with?("thin-")
            str  = "thin stop -Ptmp/pids/#{file}"
            #puts "Running #{str} \n"
            puts "Stopping server on port #{file[/\d+/]}... \n"
            `#{str}`
          end
        end
      end
    end
  end
end
