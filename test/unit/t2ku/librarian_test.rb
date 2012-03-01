require 'test_helper_t2ku'

module T2Ku
  class LibrarianTest < MiniTest::Unit::TestCase
    def test_librarian_will_create_nonexistent_root_dir
      book_dir_now = File.join($test_base_dir,'books_tmp')
      FileUtils.rm_rf(book_dir_now) if Dir.exists?(book_dir_now)
      assert(!Dir.exists?(book_dir_now))
      lib = Librarian.new(:base_path => book_dir_now)
      assert(Dir.exists?(book_dir_now))
    end
    
    def test_librarian_will_create_book_git_if_nonexistent
      book_dir_now = File.join($test_base_dir,'books_tmp')
      FileUtils.rm_rf(book_dir_now) if Dir.exists?(book_dir_now)
      lib = Librarian.new(:base_path => book_dir_now)
      assert(Dir.exists?(book_dir_now))
      bookname = 'some_book'
      assert(!lib.book_exists?(book_name))
      lib.make_book!(book_name)
      assert(lib.book_exists?(book_name))
      assert(lib.book_gitpath(book_name)).length>0)
      path = lib.book_gitpath(book_name)
      assert(Dir.exists?(path))
    end
    
    def test_librarian_will_give_me_books
      book_dir_now = File.join($test_base_dir,'books_tmp')
      FileUtils.rm_rf(book_dir_now) if Dir.exists?(book_dir_now)
      lib = Librarian.new(:base_path => book_dir_now)
      assert(Dir.exists?(book_dir_now))
      bookname = 'some_book'
      assert(!lib.book_exists?(book_name))
      book = lib.book(book_name)
      assert(lib.book_exists?(book_name))
      assert_instance_of(book,Book)
    end
  end
end
