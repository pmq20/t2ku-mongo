require 'fileutils'

module T2Ku
  class Librarian
    def initialize(opts={})
      raise 'Missing critical arguments' if opts[:base_path].blank?
      @base_path = opts[:base_path]
      unless Dir.exists?(@base_path)
        Dir.mkdir(@base_path,0700)
      end
      @base_dir = Dir.new(@base_path)
      Dir.chdir(@base_path)
    end
    
    def delete_all_books!
      Dir.rm_rf()
    end
    
    def books
    end

    
  end
end