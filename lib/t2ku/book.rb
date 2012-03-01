module T2Ku
  class Book
    attr_reader :path
    attr_reader :repo
    attr_reader :wiki
    def initialize(path)
      @path = path
      @repo = Grit::Repo.new(path)
      @wiki = Gollum::Wiki.new(path,:page_class => Page,:file_class => TFile)
    end
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
  end

end
