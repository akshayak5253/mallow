class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :read, :all
    can :update, Topic do |topic|
      topic.user == user
    end

    can :update, Post do |post|
      post.topic.user == user
    end

    can :update, Comment do |comment|
      comment.post.topic.user == user
    end
    can :update, Comment, user_id: user.id
  end
end
