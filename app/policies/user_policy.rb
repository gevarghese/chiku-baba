# app/policies/user_policy.rb
class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
  
  def show?
    user.admin? || user == record
  end
  
  def update?
    user.admin?
  end
  
  def destroy?
    user.admin?
  end
  
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end