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
  attr_reader :wiki
  # ================================= 【AttrBehavior】 ============================================
  # -------------------- 1.guard -------------------------------
  # ------------------- 2.relationship -------------------------
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :users
  embeds_one :root_page
  # ------------------- 3、validations --------------------------
  validates_presence_of :title
  validates_uniqueness_of :title
  # ------------------------------------------------------------
  # ================================= 【Instance】 =============================================
  def wiki_path
    if self.id
      File.expand_path("books/#{self.id}.git/",Rails.root)
    else
      nil
    end
  end
  
  def create_book_git!
     if self.wiki_path
      if(!File.exists?(self.wiki_path))
        # now create the git repository for the book
        p cmd="cd #{Rails.root}#{Setting.book_path};git init;mv .git #{self.id}.git"
        p `#{cmd}`
      end
    end
  end
  # ================================= 【Hookers】 ==============================================
  after_initialize Proc.new{
     @wiki = Gollum::Wiki.new(self.wiki_path, {}) if self.wiki_path
  }
  after_create :create_book_git!
  # ================================= 【Class】 =============================================
  
end
