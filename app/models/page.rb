# -*- encoding : utf-8 -*-
class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include BaseModel
  # ================================= 【Attr】 ===============================================
  field :title
  slug :title
  field :rank, :type => Float, :default => 0
  attr_reader :page
  # ================================= 【AttrBehavior】 ============================================
  # -------------------- 1.guard -------------------------------

  # ------------------- 2.relationship -------------------------
  recursively_embeds_many
  belongs_to :book
  # ------------------- 3、validations --------------------------

  # ------------------------------------------------------------
  scope :well_ordered,asc('rank')
  # ================================= 【Instance】 =============================================
  # def brothers
  #   self.book.items.where(item_id:self.item_id)
  # end
  # 
  # def next
  #   ret = self.brothers.where('rank>?',self.rank).rank.first
  #   ret = self.children.rank.first if !ret and self.children
  #   ret
  # end
  # 
  # def prev
  #   ret = self.brothers.where('rank<?',self.rank).order('rank desc').first
  #   ret = self.father.brothers.where('rank<?',self.rank).order('rank desc').first if !ret and self.father
  #   ret
  # end
  # ================================= 【Hookers】 ==============================================
  after_initialize Proc.new{
    if self.book and self.title
      @page = self.book.wiki.page(self.title)
    end
  }
  # ================================= 【Class】 ==========================================


end
