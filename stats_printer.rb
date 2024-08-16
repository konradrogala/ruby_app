class StatsPrinter
  def initialize(file_name, stats_type)
    @file_name = file_name
    @stats_type = stats_type
  end

  def perform
    return unless file_data

    if stats_type == 'UNIQ'
      counted_uniq_logs = group_by_occurence(file_data.uniq)

      puts humanized_stats(sort_descending(counted_uniq_logs))
    elsif stats_type == 'MOST_VIEWED'
      counted_logs = group_by_occurence(file_data)

      puts humanized_stats(sort_descending(counted_logs))
    else
      puts 'wrong argument given, use UNIQ or MOST_VIEWD'
    end
  end

  private

  attr_reader :file_name, :stats_type

  def group_by_occurence(collection)
    collection.map(&:first).tally
  end

  def sort_descending(collecition)
    collecition.sort_by { |_, v| -v }
  end

  def file_data
    @file_data ||= begin
      File.open(file_name).map do |line|
        line.split(' ')
      end
    rescue Errno::ENOENT
      puts 'file does not exist'
    end
  end

  def humanized_stats(sorted_stats)
    sorted_stats.map do |k, v|
      "#{k} - #{v} uniq views"
    end
  end
end
