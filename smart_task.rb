
def group_by_occurence(collection)
  collection.map(&:first).tally
end

def sort_descending(collecition)
  collecition.sort_by { |_, v| -v }
end

begin
  file_data = File.open(ARGV[0]).map do |line|
    line.split(' ')
  end
rescue Errno::ENOENT
  puts 'file do not exist'
  return
end

def humanized_stats(sorted_stats)
  sorted_stats.map do |k, v|
    "#{k} - #{v} uniq views"
  end
end

if ARGV[1] == 'UNIQ'
  counted_uniq_logs = group_by_occurence(file_data.uniq)

  puts humanized_stats(sort_descending(counted_uniq_logs))
elsif ARGV[1] == 'MOST_VIEWED'
  counted_logs = group_by_occurence(file_data)

  puts humanized_stats(sort_descending(counted_logs))
else
  puts 'wrong argument given, use UNIQ or MOST_VIEWD'
end
