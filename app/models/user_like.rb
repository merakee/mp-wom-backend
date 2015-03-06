class UserLike < ActiveRecord::Base
  belongs_to :user

  validates :user, :userid_liked,  presence: true

  validates :user_id, uniqueness: { scope: [:userid_liked],
    message: "User already liked this user. User cannot like same user more than once." }

  # update content stats
  after_save :update_user_stat

  private
  def update_user_stat
    UserStatManager.update_with_like(self)
  end

end
