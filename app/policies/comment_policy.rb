# app/policies/comment_policy.rb
class CommentPolicy < ApplicationPolicy
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