require 'test_helper_t2ku'
module T2Ku
  class BookTest < MiniTest::Unit::TestCase
    def test_book_will_give_me_repos
      book_dir_now = File.join($test_base_dir,'books_tmp')
      FileUtils.rm_rf(book_dir_now) if Dir.exists?(book_dir_now)
      lib = Librarian.new(book_dir_now)
      assert(Dir.exists?(book_dir_now))
      bookname = 'some_book'
      book = lib.book(bookname)
      path = lib.book_gitpath(bookname)
      repo = book.repo
      assert_kind_of(Grit::Repo,repo)
      assert_equal(repo.path,path)
      assert_equal(book.path,path)
      assert_equal(repo.bare,true)
    end
    def test_book_will_create_pages
      book_dir_now = File.join($test_base_dir,'books_tmp')
      FileUtils.rm_rf(book_dir_now) if Dir.exists?(book_dir_now)
      lib = Librarian.new(book_dir_now)
      assert(Dir.exists?(book_dir_now))
      bookname = 'some_book'
      book = lib.book(bookname)
      page_titles = []
      1.upto(10).each do |i|
        page_titles << "Page #{i} $#{rand}$"
      end
      book.make_pages!(page_titles,:format => 'markdown')
      assert_equal(book.pages.count,page_titles.count)
      old_count = book.pages.count
      # repete-safe
      page_titles << page_titles[-1]
      book.make_pages!(page_titles,:format => 'markdown')
      assert_equal(old_count,book.pages.count)
      # page_exists?
      page_titles.each do |title|
        book.page_exists?(title)
      end
    end
    
    
  end
end
