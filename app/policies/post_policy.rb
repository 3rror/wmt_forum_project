class PostPolicy < ApplicationPolicy
  def update?
    user.admin? or record.user.id == user.id && record.created_at > 24.hours.ago
  end

  def destroy?
    update?
  end
end
