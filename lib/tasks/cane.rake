begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 15
    cane.add_threshold 'coverage/.last_run.json', :>=, 95
    cane.no_style = true
  end
rescue LoadError
  warn "cane not available, quality task not provided."
end
