class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Order, user_id: user.id
    can :read, Product

    if user.is_a? AdminUser
      can :manage, Product
      can :manage, User
      can :manage, Order
    end
  end
end
