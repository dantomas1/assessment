# README
Fix the following snippet. Given a collection of 1000 draft Articles, update all of them to be published

Post.where(status: :draft).each { |p| p.update_attributes(status: :published}

1000 draft Articles to be updated to published. There are many ways to do it but I think creating a scope relation inside the Post model and then create a subclass for Post class, possibly named publish with controller and index route. Then from #app/controllers/draft_controller.rb you can create index action containing instance variable like this:

 #app/models/post.rb 

 class Post < ActiveRecord::Base

    belongs_to :user

    has_many :comments

    scope :publish1000, ->() {where(status: "draft").limit(1000).update_all(status: "published")}

    scope :drafts, ->() {where(status: "published").limit(2).update_all(status: "draft")}

    scope :pablish, -> () { where(status: "published")}
 
 end
 
  #app/models/draft.rb
  
   class Draft < Post

   end
 
 #app/controllers/draft_controller.rb
 
 class DraftController < ApplicationController

  def index

     @publish2only = Post.publish1000
  
  end
 
 end
 
 Because Active Record scope can be associated with a Proc(built-in class) represents a Ruby block as an object, like blocks they carry around context where they were defined. Therefore Ctive Record scope may have arguements, that is why we are able to run this inside the Post model :
   
   scope :drafts, ->() {where(status: "published").limit(1000).update_all(status: "draft")}
   
   scope :publish1000, ->() {where(status: "draft").limit(1000).update_all(status: "published")}
	
	

Given the following model tables, Use ActiveRecord to present the following serialized response. Optimize your code for performance.

In this we will use ActiveModel::Serializers, it will create pretty JSON format, although the source of the data will be optimized with something like Materialized view concept in large project. So we will grab gem 'active_model_serializers', '~> 0.10.0' into our Gemfile and bundle install it. Then we run the "rails generate serializer user" (same for post and comment)  this will generate the user_serializer, and the two others inside serializer folder which is inside app folder. Then we open up the #app/serializers/user_serializer.rb and edit it this way:

  class UserSerializer < ActiveModel::Serializer

    attributes :id, :username, :email

    has_many :posts

    class PostSerializer < ActiveModel::Serializer

       attributes :id, :title, :comments

       belongs_to :user

    end

  end

 "The generated serializer will contain basic attributes and has_many/has_one/belongs_to declarations, based on the model." Quote from the official github page. 
 As you can see we embedded the PostSerializer inside UserSerializer and declared the comments object as an attribute and ofcourse reciprocated the relationship status declaration of UserSerializer. Ofcourse we have the models structured too:
 
   #app/models/user.rb
 
  class User < ActiveRecord::Base

    has_many :comments
   
    has_many :posts

  end
 
  #app/models/comments.rb

  class Comment < ActiveRecord::Base

    belongs_to :post

    belongs_to :user
  
  end
 
   #app/models/post.rb 
 
  class Post < ActiveRecord::Base

    belongs_to :user

    has_many :comments

    scope :publish1000, ->() {where(status: "draft").limit(1000).update_all(status: "published")}

    scope :drafts, ->() {where(status: "published").limit(2).update_all(status: "draft")}
   
    scope :pablish, -> () { where(status: "publish")}
 
  end
  
   #app/serializers/comment_serializer.rb

   class CommentSerializer < ActiveModel::Serializer

     attributes :id, :content
     
     #:belongs_to :user

     belongs_to :post

   end
 
  #app/serializers/comment_serializer.rb

  class PostSerializer < ActiveModel::Serializer

    attributes :id, :title

    belongs_to :user

    has_many :comments
   
  end
 
   #app/controllers/users_controller.rb

  class UsersController < ApplicationController

   def index

     @users = User.all

     respond_to do |format|

      format.json { render json: @users }

     end

   end

   def show

    @user = User.find(params[:id])

    @user = @user.posts

      respond_to do |format|

        format.json { render json: @user }

      end

    end

  end


 When it is all routed corectly when you go to http://localhost:3000/users.json it will render the pretty JSON format as in the question, and it is done the rail way .
 
 
 
 What is self.included? How would you use it in mixins?
 
 Mixin is like a specialized implementation of multiple inheritance in which only the interface portion is inherited. 
 included is a hook that is called when an include happens. To use this self.included method in a mixin we embed singleton method inside, be aware you cannot define and instance method this way else it will result in a Nested method error. So to call the instance method of the module inside the class we will have to instantiate it first with "x = Orange.new", only then we can call it. 
 
 module Color

    def self.included(klass)

       def klass.primary_color
          puts "Module primary(class) color"
       end

    end

    def yellow
       puts "i'm yellow"
    end

 end

 class Orange

    include Color

    def self.ripe_orange
      puts "I'm ripe orange"
    end
    def tiny
       puts "tiny orange"
    end

 end	

 x = Orange.new

 Orange.ripe_orange      #I'm ripe orange

 x.tiny                  #tiny orange

 Orange.primary_color    #Module primary (class) color

 x.yellow                #i'm yellow
   
   But there is another way to use the included hook.
   
   
 module Color

    def yellow
       puts "i'm yellow"
    end

 end

 class Orange

    class << self
       include Color
    end

 end
   
 Orange.yellow     #i'm yellow
   
   Here we mix in the instance methods of a module as a class methods using include, works the same as the self.included with it's inner singleton methods.



Why is it bad to use rescue in the following manner? What do you understand about the ruby exception hierarchy?

 begin
 
    do_something()

    rescue Exception => e

    puts e

 end

Because Exeption is the root of Ruby's exception hierarchy, it is the sire of all the exceptions, so when you rescue it, you rescue everything including subclasses such as SyntaxError(evals that fail will do so silently, LoadError, and Interrupt (prevents the user from using CTRLC to exit the program). It is much better to narrow rescue to a particular error instead of broadening it. 

Ruby exception hierarchy is the hierarcy of things that can possibly go wrong inside a ruby project/code. At the very root of this hierarchy you will find exception, then it's children and grandchildren and great grandchildren etc.



A cooperation booth sells gloves in singles and pairs. Each transaction may be a purchase of a single side of glove, or a combination of left/right gloves. It is invalid, however, when a combination of right-right or left-left gloves to be sold.

Given the following data, write a SQL query to list the duplicate gloves (for both left-left and right-right) sold.


This is quite straightforward with the help of Active Record scope. As shown below.

  #app/models/glove.rb

 class Glove < ActiveRecord::Base

    scope :duplis, -> { select(:transaction_id,:glove_type).group(:transaction_id,:glove_type).having("count(*) > 1") }

 end

   #app/controllers/gloves_controller.rb

 class GlovesController < ApplicationController

    def index
      @dups = Glove.duplis
    end

 end

