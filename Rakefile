namespace :boot do
  desc "Start Web Server Develop"
  task :dev do
    sh %Q{rerun -- rackup -E development -p 8080 config.ru}
  end
  desc "Start Web Server for Production"
  task :prod do
    sh %Q{rerun -- rackup -E production -p 8080 config.ru}
  end
end