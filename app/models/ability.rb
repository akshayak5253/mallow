class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :read, :all
    # can :read, :all_posts

    can :create, Question

    can :update, Question do |question|
      question.user == user
    end

    can :destroy, Question do |question|
      question.user == user
    end

    # can :mark_as_read, Post

  end
end