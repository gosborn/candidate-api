class Candidate < ApplicationRecord
  validates :status, inclusion: { in: %w(pending accepted rejected) }
  validates :years_exp, numericality: { less_than_or_equal_to: 50 }
  validate :status_cannot_be_pending_if_reviewed

  scope :reviewed, -> (reviewed) { where reviewed: reviewed }

  before_save :sync_reviewed

  private
  def sync_reviewed
    if %w(accepted rejected).include?(self.status)
      self.reviewed = true
    end
  end

  def status_cannot_be_pending_if_reviewed
    if self.reviewed and self.status == 'pending'
      errors.add(:status, 'Cannot set status back to pending if candidate has been reviewed')
    end
  end
end
