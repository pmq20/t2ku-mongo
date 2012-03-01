# -*- encoding : utf-8 -*-
class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
  
  # ================================= 【Attr】 ===============================================
  field :description
  field :canonical_form
  # ================================= 【AttrBehavior】 ============================================
  # -------------------- 1.guard -------------------------------

  # ------------------- 2.relationship -------------------------
  belongs_to :user
  # ------------------- 3、validations --------------------------
  # ------------------------------------------------------------
  # ================================= 【Instance】 =============================================
  # ================================= 【Hookers】 ==============================================
  # ================================= 【Class】 ==========================================
  def self.to_canonical(description)
    description=description.split(/\s+/).join(' ')
    ret = ''
    description.split('.').each do |sentence|
      ret+=sentence.split(',').collect{|sub|
        sub.strip
      }.join(',')
    end
    ret
  end
end
