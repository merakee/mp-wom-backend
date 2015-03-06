require 'rails_helper'
def able_to_get_user(path,user,user_id,msg=nil)
    post path, auth_params(user).merge({params:{user_id: user_id}})
    expect_response_to_have(response,sucess=true,status=:ok,msg)
    expect(json["user"]).not_to be_nil     
    expect(json["user"]).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown","verified","like_count","did_like")
    expect(json["user"]["id"]).to eq(user_id)
end

def not_able_to_get_user(path,user,user_id,msg=nil)
    post path, auth_params(user).merge({params:{user_id: user_id}})
    expect_response_to_have(response,sucess=false,status=:unauthorized,msg)
end

shared_examples "get user profile" do
  it 'can get user profile' do
    able_to_get_user(getprofile_path,user,userp.id)
  end

  it 'cannot get user profile if email is missing' do
    user.email=""
    not_able_to_get_user(getprofile_path,user,userp.id)
  end

  it 'cannot get user profile if token is missing' do
    user.authentication_token=""
    not_able_to_get_user(getprofile_path,user,userp.id)
  end

  it 'cannot get user profile if email is wrong' do
    user.email="user@wrong.com"
    not_able_to_get_user(getprofile_path,user,userp.id)
  end

  it 'cannot get user profile if token is wrong' do
    user.authentication_token = user.authentication_token.chop
    not_able_to_get_user(getprofile_path,user,userp.id)
  end
end

shared_examples "update user profile" do
  it 'can update user profile with all fields' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:email,:password, :password_confirmation,:nickname,:avatar,:bio,:hometown,:social_tags]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(userm.bio)
    expect(json['user']["nickname"]).to eq(userm.nickname)
    expect(json['user']["email"]).to eq(userm.email)
    expect(json['user']["hometown"]).to eq(userm.hometown)
    expect(json['user']["social_tags"]).to eq(userm.social_tags)
  end

  it 'can update user profile with only email' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:email]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(user.bio)
    expect(json['user']["nickname"]).to eq(user.nickname)
    expect(json['user']["email"]).to eq(userm.email)
    expect(json['user']["hometown"]).to eq(user.hometown)
    expect(json['user']["social_tags"]).to eq(user.social_tags)
  end
  
    it 'can update user profile with only nickname' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:nickname]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(user.bio)
    expect(json['user']["nickname"]).to eq(userm.nickname)
    expect(json['user']["email"]).to eq(user.email)
    expect(json['user']["hometown"]).to eq(user.hometown)
    expect(json['user']["social_tags"]).to eq(user.social_tags)
  end
  
    it 'can update user profile with only bio' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:bio]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(userm.bio)
    expect(json['user']["nickname"]).to eq(user.nickname)
    expect(json['user']["email"]).to eq(user.email)
    expect(json['user']["hometown"]).to eq(user.hometown)
    expect(json['user']["social_tags"]).to eq(user.social_tags)
  end
  
    it 'can update user profile with only hometown' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:hometown]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(user.bio)
    expect(json['user']["nickname"]).to eq(user.nickname)
    expect(json['user']["email"]).to eq(user.email)
    expect(json['user']["hometown"]).to eq(userm.hometown)
    expect(json['user']["social_tags"]).to eq(user.social_tags)
  end
  
  
    it 'can update user profile with only social tags' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:social_tags]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(user.bio)
    expect(json['user']["nickname"]).to eq(user.nickname)
    expect(json['user']["email"]).to eq(user.email)
    expect(json['user']["hometown"]).to eq(user.hometown)
    expect(json['user']["social_tags"]).to eq(userm.social_tags)
  end
  
    it 'can update user profile without email or password modification' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:nickname,:avatar,:bio,:hometown,:social_tags]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(userm.bio)
    expect(json['user']["nickname"]).to eq(userm.nickname)
    expect(json['user']["email"]).to eq(user.email)
    expect(json['user']["hometown"]).to eq(userm.hometown)
    expect(json['user']["social_tags"]).to eq(userm.social_tags)
  end
  
    it 'can update user profile with only email or password modification' do
    userm = build(:user)
    post updateprofile_path, auth_params(user).merge(params: userm.as_json(only: [:email,:password, :password_confirmation]))
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["bio"]).to eq(user.bio)
    expect(json['user']["nickname"]).to eq(user.nickname)
    expect(json['user']["email"]).to eq(userm.email)
    expect(json['user']["hometown"]).to eq(user.hometown)
    expect(json['user']["social_tags"]).to eq(user.social_tags)
  end
  
  it 'cannot update user profile without user email' do
    post updateprofile_path, user.as_json(root: true, only: [:authentication_token]).merge(params: user.as_json(only: [:email,:nickname,:avatar,:bio,:hometown,:social_tags]))
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end

  it 'cannot update user profile with empty user email' do
    user.email =""
    post updateprofile_path, auth_params(user).merge(params: user.as_json(only: [:email,:nickname,:avatar,:bio,:hometown,:social_tags]))
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end

  it 'cannot update user profile without user auth token' do
    post updateprofile_path, user.as_json(root: true, only: [:email]).merge(params: user.as_json(only: [:email,:nickname,:avatar,:bio,:hometown,:social_tags]))
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end

  it 'cannot update user profile with empty auth token' do
    user.authentication_token =""
    post updateprofile_path, auth_params(user).merge(params: user.as_json(only: [:email,:nickname,:avatar,:bio,:hometown,:social_tags]))
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end

  it 'cannot update user profile without user info ' do
    post updateprofile_path, params: user.as_json(only: [:email,:nickname,:avatar,:bio,:hometown,:social_tags])
    expect_response_to_have(response,sucess=false,status=:unprocessable_entity)
  end

 
    xit 'can update user profile with photo' do
      user = build(:user,:with_photo, user_id: nil)

      userwp = {user: 
          {user_category_id: user.user_category_id,
          text: user.text,
          photo_token: {
          file: Base64.encode64(File.new(user.photo_token.url, 'rb').read),
          filename: "image.jpg",
          user_type: "image/jpeg"}
          }
        }
    #post path, auth_params(user).merge(user.as_json(root: true, only: [:user_category_id, :text, :photo_token]))
    post updateprofile_path, auth_params(user).merge(userwp)      
    # expect_response_to_have(response,sucess=true,status=:created)
    # check that the attributes are the same.
    expect(json['user']).to include('user_id','user_category_id','text','photo_token')
    expect(json['user']).not_to include('kill_count','no_response_count','spread_count','total_spread')
    expect(json['user']['user_id']).to eq(userp.id)
    expect(json['user']['user_category_id']).to eq(user.user_category_id)
    expect(json['user']['text']).to eq(user.text)
    expect(json['user']['photo_token']).not_to be nil 
    expect(json['user']['photo_token']['url']).not_to be nil 
    expect(json['user']['photo_token']['url']).to include("wombackend-dev-freelogue")
    
    expect(json['user']['photo_token']['thumb']).not_to be_nil
    expect(json['user']['photo_token']['thumb']['url']).not_to be nil 
    expect(json['user']['photo_token']['thumb']['url']).to include("wombackend-dev-freelogue")
  end
  
    it 'cannot update like_count' do
    lcount=rand(100)
    post updateprofile_path, auth_params(user).merge(params: {like_count:lcount})
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["like_count"]).to eq(user.like_count)
  end
  
  it 'cannot update verified' do
    verified=rand(2)>0
    post updateprofile_path, auth_params(user).merge(params: {verified:verified})
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json['user']).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown", "verified","like_count")
    expect(json['user']["verified"]).to eq(user.verified)
  end
end

shared_examples "user varification access" do          
  it 'can verify user profile' do
    ENV['ADMIN_PASS']="admin_pass"
    #dputs ENV['ADMIN_PASS']
    userm = create(:user)
    #verified = rand(2)>0
    params= {params: {user_id: userm.id, admin_pass:"admin_pass",verified:true}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json["user"]).not_to be_nil     
    expect(json["user"]).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown","verified","like_count")
    expect(json["user"]["verified"]).to be_truthy
  end

  it 'can unverify user profile ' do
    userm = create(:user)
    userm.verified = true
    params= {params: {user_id: userm.id, admin_pass:"admin_pass",verified:false}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=true,status=:ok)
    # check that the attributes are the same.
    expect(json["user"]).not_to be_nil     
    expect(json["user"]).to include("id","user_type_id","nickname","avatar","bio","social_tags","hometown","verified","like_count")
    expect(json["user"]["verified"]).to be_falsy
  end
  
  it 'cannot verify user without admin pass' do
    userm = create(:user)
    params= {params: {user_id: userm.id,verified:true}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end
  
  it 'cannot verify user with empty admin pass' do
    userm = create(:user)
    #verified = rand(2)>0
    params= {params: {user_id: userm.id, admin_pass:"",verified:true}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end

  it 'cannot verify user with nil admin pass' do
    userm = create(:user)
    #verified = rand(2)>0
    params= {params: {user_id: userm.id, admin_pass:nil,verified:true}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end

  it 'cannot verify user with nil ENV admin pass' do
    ENV['ADMIN_PASS']=nil
    userm = create(:user)
    #verified = rand(2)>0
    params= {params: {user_id: userm.id, admin_pass:nil,verified:true}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end
  
  it 'cannot verify user with empty ENV admin pass' do
    ENV['ADMIN_PASS']=""
    userm = create(:user)
    #verified = rand(2)>0
    params= {params: {user_id: userm.id, admin_pass:"",verified:true}}
    post verifyuser_path, auth_params(user).merge(params)
    expect_response_to_have(response,sucess=false,status=:unauthorized)
  end
  
end


shared_examples "cannot get user profile" do
  it 'cannot get user profile' do
    not_able_to_get_user(getprofile_path,user,userp.id)
  end
end

describe "API User Profile" do  
  let(:getprofile_path) {"/api/v0/users/profile"}
  let(:updateprofile_path){"/api/v0/users/update"}
  let(:verifyuser_path){"/api/v0/users/verify"}

    
  describe "user: normal " do  
    let(:user) {create :user}
    let(:userp) {create :user}
    it_behaves_like  "get user profile"
    it_behaves_like  "update user profile"
    it_behaves_like  "user varification access"
  end
  
  describe "user: anonymous user" do
    let(:user) {get_user_anonymous}
    let(:userp) {create :user}
    it_behaves_like  "get user profile"
  end

end
