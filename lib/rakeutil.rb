require "fileutils"
include FileUtils::Verbose
require "timeout"
include Timeout
require "benchmark"
include Benchmark
require "rubygems"
require "ostruct"

def const(k, v)
  k = k.to_s
  $rake_consts ||= []
  $rake_consts << k
  Kernel.const_set(k, ENV[k] || v)
end

def system?(cmd)
  puts cmd
  Kernel.system(cmd) or exit unless $dry
end

def system(cmd)
  puts cmd
  Kernel.system(cmd) unless $dry
end

def jx(*args)
  system "java -cp #{RAKE_CLASSPATH} #{RAKE_JAVA_OPTS} #{args.join(" ")}"
end

const :RAKE_CLASSPATH, (Dir["**/*.jar"] << "bin").join(":")
const :RAKE_JAVA_OPTS, " -Xmx1g "

class Object
  def to_os
    self
  end
end

class Hash
  def to_os
    inject({}){ |memo, (k, v)| memo[k] = v.to_os; memo }
  end
end

class Array
  def to_os
    map{|e| e.to_os }
  end
end

def shell_script_test(files)
  succeeded = 0
  failed = 0
  
  log_file = Module.const_defined?(TEST_LOG) ? File.open(TEST_LOG, "w") : STDER
  
  log_file do |log|
    files.each do |file|
      log.puts `#{file} 2>&1`
      if $?.exitstatus == 0
        print "."
        STDOUT.flush
        succeeded += 1
      else
        print "F"
        STDOUT.flush
        failed += 1
      end
    end  
  end
  
  total = succeeded + failed
  puts
  puts "#{succeeded} of #{total} tests succeeded"
  exit succeeded == total ? 0 : 1
end


namespace :util do

  desc "cat rakeutil's README"
  task :readme do
    puts File.read(File.dirname(__FILE__) + "/../README")
  end
  
  desc "Don't let fileutils and compatible commands affect the fs"
  task :dry => :dry_run do
  end
  
  desc "Don't let fileutils and compatible commands affect the fs"
  task :dry_run do
    include FileUtils::DryRun
    $dry = true
  end

  desc "Pretty-print all rakeutil constants"
  task :constants do
    $rake_consts.sort.each {|c| puts c + "\t" + const_get(c).inspect }
  end
  
end