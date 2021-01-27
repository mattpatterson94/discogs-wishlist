module ThreadsPerSlice
  def threads_per_slice(enumerator, number_of_slices)
    threads = []

    enumerator.each_slice(number_of_slices) do |slice|
      threads << Thread.new { yield slice }
    end

    threads.each(&:join)
  end
end
