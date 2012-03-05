# -*- encoding : utf-8 -*-
class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include BaseModel
  # ================================= 【Attr】 ===============================================
  field :title
  slug :title
  field :description
  field :memo
  attr_reader :path
  attr_reader :repo
  attr_reader :wiki
  # ================================= 【AttrBehavior】 ============================================
  # -------------------- 1.guard -------------------------------
  # ------------------- 2.relationship -------------------------
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :editors
  embeds_one :root_page
  # ------------------- 3、validations --------------------------
  validates_presence_of :title
  validates_uniqueness_of :title
  # ------------------------------------------------------------
  # ================================= 【Instance】 =============================================
  # Accepts Array
  # Will transfer `page` to slugs
  def make_pages!(page,opts={})
    raise "Missing Critical Argument" if opts[:format].blank?
    opts[:content]||=''
    opts[:message]||='Created from DB'
    opts[:name]||='T2Ku::Book'
    opts[:email]||='t2ku@t2ku.org'
    if page.respond_to?(:each)
      page.each do |p|
        make_pages!(p,opts)
      end
    else
      page = page.to_url
      return if page_exists?(page)
      @wiki.write_page(page, opts[:format].intern, opts[:content], opts.slice(:message,:name,:email))
    end
  end
  
  def pages
    @wiki.pages
  end
  
  def page_exists?(page)
    nil != @wiki.page(page)
  end

  # ================================= 【Hookers】 ==============================================
  after_initialize Proc.new{
    @path = self.slug
    @repo = Grit::Repo.new(path)
    @wiki = Gollum::Wiki.new(path,:page_class => Page,:file_class => TFile)
  }
  after_create :create_book_git!
  # ================================= 【Class】 =============================================

  class << self
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
