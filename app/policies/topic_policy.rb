class TopicPolicy < ApplicationPolicy
  def update?
    user.admin? or record.author.id == user.id && record.created_at > 24.hours.ago
  end

  def destroy?
    update?
  end
end
