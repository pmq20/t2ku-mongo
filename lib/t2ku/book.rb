require 'grit'

module T2Ku
  class Book
    def make_git!
      if(!git_exists?)
        Grit::Repo.new
      end
    end

    def git_exists?
      File.exists?(git_path)
    end

    def git_path
      "#{@base_path}/#{@title}.git"
    end
  end

end
