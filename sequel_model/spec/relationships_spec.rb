require File.join(File.dirname(__FILE__), "spec_helper")

#__END__

# class Post < Sequel::Model
#   relationships do
#     has :one,  :blog, :required => true, :normalized => false # uses a blog_id field, which cannot be null, in the Post model
#     has :one,  :account # uses a join table called accounts_posts to link the post with it's account.
#     has :many, :comments # uses a comments_posts join table
#     has :many, :authors, :required => true  # authors_posts join table, requires at least one author
#   end
# end
describe Sequel::Model "relationships" do
  before :all do
    class Smurf < Sequel::Model
    end
  end
  
  after :all do
    Smurf.model_relationships.clear
  end
  
  describe "has" do
    
    it "should raise an exception if an arity {:one, :many} is not specified" do
      Smurf.should_not_receive(:auto_create_join_table).with(:smurfette, {}).and_return(true)
      Smurf.should_not_receive(:relationship_exists?).with(:one, :smurfette).and_return(true)
      Smurf.stub!(:after_initialize)
      lambda {
      class Smurf
        relationships do
          has :sex, :with_smurfette
        end
      end
      }.should raise_error Sequel::Error, "Arity must be specified {:one, :many}." 
    end
    
    it "should check to see if the relationship exists" do
      Smurf.should_not_receive(:relationship_exists?).with(:one, :smurfette).and_return(true)
      Smurf.stub!(:after_initialize)
      lambda {
      class Smurf
        relationships do
          has :sex, :with_smurfette
        end
      end
      }.should raise_error Sequel::Error, "Arity must be specified {:one, :many}."
    end
    
    it "should raise an exception if the relationship has already been specified" do
      Smurf.should_receive(:relationship_exists?).with(:one, :smurfette).and_return(true)
      Smurf.stub!(:after_initialize)
      lambda {
      class Smurf
        relationships do
          has :one, :smurfette
        end
      end
      }.should raise_error Sequel::Error, "The relationship 'Smurf has one smurfette' is already defined."
    end
    
    it "should establish a has :one relationship" do
      Smurf.stub!(:auto_create_join_table)
      Smurf.should_receive(:relationship_exists?).with(:one, :smurfette).and_return(false)
      Smurf.should_receive(:after_initialize)
      class Smurf
        relationships do
          has :one, :smurfette 
        end
      end
      
      @smurf = Smurf.new
    
    end
    
    it "should establish a has :many relationship" do
      Smurf.should_receive(:auto_create_join_table).with(:smurfette, {}).and_return(true)
      Smurf.should_receive(:relationship_exists?).with(:many, :smurfette).and_return(false)
      Smurf.should_receive(:after_initialize)
      class Smurf
        relationships do
          has :many, :smurfette 
        end
      end
      
      @smurf = Smurf.new
    end
    
    it "should call the auto_create_join_table method" do
      Smurf.should_receive(:auto_create_join_table).with(:smurfette, {}).and_return(true)

      class Smurf
        relationships do
          has :one, :smurfette
        end
      end
    end
    
    it "should store the relationship to ensure there is no duplication" do
      pending("Need to test")
    end
    
    it "should call the 'define relationship method' method" do
      pending("Need to test")
    end
  end

  describe Sequel::Model, "belongs_to" do
    it "should put the smack down on yer bitches" do
      pending("Need to test")
    end
  end

end