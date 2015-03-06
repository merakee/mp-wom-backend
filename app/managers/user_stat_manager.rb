class UserStatManager
 def self.update_with_like(user_like)
   update_incrementally(user_like)
 end

 def self.update_incrementally(user_like)
      User.update_counters user_like.userid_liked, :like_count => 1
 end

 def self.update_stat(user_like)
   User.update(user_like.user_id, like_count: get_like_count_for_user(user_like.userid_liked))
 end
  
 def self.update_all_stat
    User.find_each do |user|
      update_stat(user)
   end
 end

  def self.get_like_count_for_user(userid_liked)
    UserLike.where(userid_liked: userid_liked).count
  end
    
  def self.check_all_stat
          total_errors=0;
    User.find_each do |user|
      total_errors += check_count_and_stat(user)
    end
   Rails.logger.info "User Stat:: Total mismatch: #{total_errors}"
  end
  
  def self.check_count_and_stat(user)  
    like_count = get_like_count_for_user(user.id)  
   if user.like_count!= like_count
     #Rails.logger.info "Mismatch found: #{content.id}...updating information"
     user.update(like_count: like_count)
     return 1
   end
   return 0 
  end

end