#!/usr/bin/env ruby -w -U
# encoding: UTF-8
# (с) ANB Andrew Bizyaev Андрей Бизяев
require 'optparse'
require 'date'

module TRename
  class Options
    attr_reader :delta_time, :debug, :rest

    def initialize(argv)
      parse(argv)
      @delta_time ||= 0.0
      @debug ||= false
    end #def

  private
    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: file(s) | trename -d DELTA_TIME [-D]"
        opts.separator ""
        opts.separator "Renames input files (with names in YYYYmmdd-HHMMSS format) adding DELTA_TIME (in seconds) to YYYYmmdd-HHMMSS"
        opts.separator ""

        opts.separator "Specific options:"

        @delta_time = nil
        opts.on("-d", "--delta_time DELTA_TIME", String, "Delta in seconds to be added or substructed") do |val|
          @delta_time = val.to_f
        end

        @debug = nil
        opts.on("-D", "--debug", "Debug mode") do |val|
          @debug = val
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        opts.on_tail("-h", "-?", "--about", "--help", "Show this message") do
          puts opts
          exit 1
        end

        opts.on_tail("-v", "--version", "--ver", "Show version") do
          puts "version: #{TRename::VERSION}"
          exit 1
        end

        begin
          argv = ["-h"] if argv.empty?
          @rest = opts.parse!(argv)

        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(1)
        end
      end
    end #def

  end #class
end #module
