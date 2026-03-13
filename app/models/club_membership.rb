class ClubMembership < ApplicationRecord
  belongs_to :user
  belongs_to :club

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :user_id, uniqueness: { scope: :club_id }
end