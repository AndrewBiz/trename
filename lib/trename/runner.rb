#!/usr/bin/env ruby -w -U
# encoding: UTF-8
# (с) ANB Andrew Bizyaev Андрей Бизяев 

require_relative 'version'
require_relative 'options'
require 'fileutils'

module TRename 

  class Runner
    def initialize(argv)
      @options = Options.new(argv)
      p @options if @options.debug
    end #initialize

    def run
      ARGV.clear
      ARGF.each_line do |line|
        file_in = File.basename(line).chop
        #name_prefix = %Q{#{@date_time_original.strftime('%Y%m%d-%H%M%S')}_#{@author_nikname}}
        # check if name = YYYYMMDD-hhmmss-AAA[ID]name
        if (/^(\d{8}-\d{6})(.*)/ =~ file_in)
          date_in = DateTime.strptime($1, "%Y%m%d-%H%M%S")          
          name_clean = $2
          date_out = date_in + @options.delta_time*(1.0/86400) #in seconds
          file_out = %Q{#{date_out.strftime('%Y%m%d-%H%M%S')}#{name_clean}}
          begin
            FileUtils.mv(file_in, file_out)
          rescue StandardError
            raise
          else
            $stdout.puts "#{file_out}"
          end
        end
      end
    end #run
  end
end
