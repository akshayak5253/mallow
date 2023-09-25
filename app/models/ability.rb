class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :read, :all
    can :create, Topic
    can :update, Topic do |topic|
      topic.user == user
    end
    can :destroy, Topic do |topic|
      topic.user == user
    end
    can :create, Post
    can :update, Post do |post|
      post.topic.user == user
    end
    can :destroy, Post do |post|
      post.topic.user == user
    end
    can :create, Comment

    can :update, Comment do |comment|
      comment.post.topic.user == user
    end
    can :destroy, Comment do |comment|
      comment.post.topic.user == user
    end
  end
end
