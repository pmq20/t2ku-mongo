module T2Ku
  class Librarian
    attr_reader :base_path
    def initialize(base_path,opts={})
      raise 'Missing critical arguments' if base_path.blank?
      @base_path = base_path
      self.class.make_sure_exists(@base_path)
      @base_dir = Dir.new(@base_path)
    end
    
    def self.make_sure_exists(path)
      unless Dir.exists?(path)
        Dir.mkdir(path,0700)
      end      
    end
    def delete_all_books!
      FileUtils.rm_rf(@base_path)
      Librarian.make_sure_exists(@base_path)
    end
    
    def book_exists?(book_name)
      path = book_gitpath(book_name)
      return false if !Dir.exists?(path)
      return false if !File.exists?(File.join(path,'objects')) # non-initialized git repo
      return true
    end
    
    def make_book!(book_name)
      bookpath = book_gitpath(book_name)
      Grit::Repo.init_bare(bookpath)
    end
    
    def book_gitpath(book_name)
      File.join(@base_path,book_name+'.git')
    end

    def book(book_name)
      make_book!(book_name) if !book_exists?(book_name)
      Book.new(book_gitpath(book_name))
    end 
  end
end