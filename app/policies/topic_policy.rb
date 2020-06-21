class TopicPolicy < ApplicationPolicy
  def update?
    record.author.id == user.id && record.created_at > 24.hours.ago
  end

  def destroy?
    update?
  end
end
