class Response
alias :read_attribute_for_serialization :send
attr_reader :poster, :posts

  def initialize(attributes)
    @poster = attributes[:poster]
    @posts = attributes[:posts]
  end

    def self.for_user(user)
    user.posts.group_by do |user_id, posts|
      Response.new({
        poster: User.find(user.id),
        posts: posts
      })
    end
  end

end
