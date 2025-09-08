# app/policies/blog_policy.rb
class BlogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.published
      end
    end
  end

  def index?
    true
  end

  def show?
    record.published? || user_is_owner_or_admin?
  end

  def create?
    user.present?
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    user.present? && (record.user == user || user.admin?)
  end
end