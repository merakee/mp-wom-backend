require 'rails_helper'

describe "API " do

  describe "User Like" do
    let(:like_path) {"/api/v0/users/like"}
    let(:user){create(:user)}
    let(:user_liked){create(:user)}

    it 'can like user' do
      #puts auth_params(user).merge({params:{user_id: user.id}})
      post like_path, auth_params(user).merge(params:{userid_liked: user_liked.id})
      expect_response_to_have(response,sucess=true,status=:created)
      # check that the attributes are the same.
      expect(json['user_like']).to include('id','user_id','userid_liked')
      expect(json['user_like']['user_id']).to eq(user.id)
      expect(json['user_like']['userid_liked']).to eq(user_liked.id)
    end

    it 'like count should increase' do
      count = user_liked.like_count
      (1..10).each { |ind|
        user1 = create(:user)
        post like_path, auth_params(user1).merge(params:{userid_liked: user_liked.id})
        expect_response_to_have(response,sucess=true,status=:created)
        # check that the attributes are the same.
        expect(json['user_like']).to include('id','user_id','userid_liked')
        expect(json['user_like']['user_id']).to eq(user1.id)
        expect(json['user_like']['userid_liked']).to eq(user_liked.id)
        count1 = User.where(id: user_liked.id).pluck(:like_count)[0]
        expect(count1).to eq(count+ind)
    }
    end
    

    it 'cannot like same user twice' do
      post like_path, auth_params(user).merge(params:{userid_liked: user_liked.id})
      post like_path, auth_params(user).merge(params:{userid_liked: user_liked.id})
      expect_response_to_have(response,sucess=false,status=:unprocessable_entity, message ="user_id"=>["User already liked this user. User cannot like same user more than once."])
    end

  end
end
