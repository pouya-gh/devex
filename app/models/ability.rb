class Ability
  include CanCan::Ability

  def initialize(current_user)
    can :read, User do |user|
      current_user == user
    end
  end
end
