require "bundler/gem_tasks"

Dir.glob('lib/tasks/*.rake').each { |r| import r }

task default: [:reek, :spec, :quality]
