#!/usr/bin/env ruby
# coding: utf-8-with-signature
# 
# Convert charactor codes and newline charactor.
# 

require 'nkf'

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))


module ConvCode

  OutputCodes = [
    'ISO-2022-JP',
    'EUC-JP',
    'eucJP-ascii',
    'eucJP-ms',
    'CP51932',
    'Shift_JIS',
    'CP932',
    'UTF-8',
    'UTF-8-BOM',
    'UTF-16',
    'UTF-16BE',
    'UTF-16BE-BOM',
    'UTF-16LE',
    'UTF-16LE-BOM',
    'UTF-32',
    'UTF-32BE',
    'UTF-32BE-BOM',
    'UTF-32LE',
    'UTF-32LE-BOM'
  ]
  OutputNewlines = [
    'CR',
    'LF',
    'CRLF'
  ]

  def conv(src, dest=nil, code='UTF-8', nl=nil, exclude_dirs = [], file_ptn=nil, quiet = false)

  end

end





if $0 == __FILE__
  require 'optparse'
  include ConvCode

  Version = "0.0.1"
  VersionBarner = "#{File.basename($0)} Ver. #{Version}"

  HelpBarnner = <<EOS
Usage:
  #{File.basename($0)} [Options] SRC [DEST]
  
SRC: Source direcotry
DEST: Destny direcotry

Options:
EOS
  
  OutputCodesBarnner = 'Charactor codes:'

    
  OptionDescripts = {
    :help     => "Show this help, and exit.",
    :version  => "Show version, and exit.",
    :code     => "Specify charactor code of output files.",
    :newline  => "Specify newline charactor of output files. [CR, LF or CRLF]",
    :exclude  => "Specify exclude directory name",
    :pattern  => "Specify regexp pattern to target files",
    :quiet    => "Quiet mode.",
  }

  
  class ArgParser
    attr_reader :src, :dest, :code, :newline, :exc_dirs, :file_ptn, :quiet
    
    def initialize
      @exc_dirs = []
      @opt = OptionParser.new

      @opt.banner = HelpBarnner

      @opt.on("-h", "--help", OptionDescripts[:help]) do |v|
        show_help
        exit
      end
      @opt.on("-v", "--version", OptionDescripts[:version]) do |v|
        puts VersionBarner
        exit
      end

      @opt.on_tail('-c', '--code=VAL', OptionDescripts[:code]) {|v|
        @code = v
      }
      @opt.on('-n', '--newline=VAL', OptionDescripts[:newline]) {|v|
        @newline = v
      }
      @opt.on('-e', '--exclude=VAL', OptionDescripts[:exclude]) {|v|
        @exc_dirs.push(v)
      }
      @opt.on('-p', '--pattern=VAL', OptionDescripts[:pattern]) {|v|
        vptn = Regexp.new(v)
        @file_ptn = @file_ptn ? vptn : Regexp.union(@file_ptn, vptn)
      }
      @opt.on("-q", "--quiet", OptionDescripts[:quiet]) do |v|
        @quiet = true
        exit
      end
    end
      
    
    def parse(args)
      begin
        ret = @opt.parse(args)
        true
      rescue => evar
        STDERR.puts(evar.to_s)
        false
      end
    end


    private
    def show_help
      puts @opt
      puts
      puts OutputCodesBarnner
      OutputCodes.each {|c|
        puts ("  " + c)
      }
    end

    
  end


  aprs = ArgParser.new

  aprs.parse(ARGV)
  
end
