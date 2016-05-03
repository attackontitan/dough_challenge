require 'csv'

desc "Import Stock Names from CSV"
task :import_csv => :environment do
  puts "Running import_csv task. This will take a while... \n ========"
  puts "Cleaning old data"
  Stock.delete_all
  csv_list = Dir[File.dirname(__FILE__) + '/../../app/assets/lists/*.csv']
  puts csv_list
  # exit

  csv_list.each do |filename|
    puts "Importing #{filename}"
    CSV.foreach(filename, :headers => true) do |row|
      stock_attr = row.to_hash.slice("Symbol", "Name")
      stock_attr[:symbol] = stock_attr.delete "Symbol"
      stock_attr[:name] = stock_attr.delete "Name"
      Stock.create(stock_attr)
    end
  end
end