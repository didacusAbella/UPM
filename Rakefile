namespace :boot do
  desc "Start Web Server"
  task :config do
    sh %Q{rerun -- rackup -E development -p 3000 config.ru}
  end
end