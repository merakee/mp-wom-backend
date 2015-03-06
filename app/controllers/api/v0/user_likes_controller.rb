class API::V0::UserLikesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!

  # Like an user given userid_liked as params 
  # @action POST
  # @url /api/v0/users/like
  # @discussion Permitted action for all users. User may like an user only once.
  # @required body
  # @response User Like Object
  # @response :unprocessable_entity
  # @response :unauthorized
  # @example_request { "user": { "user_type_id": 2, "email": "test_user1@test.com", "authentication_token": "4vFJdQTWR3TDDG_e7P2-"}, "params": { "userid_liked": 2}}
  # @example_response { "success":true,"user_like":{ "id":2,"user_id":81,"userid_liked":2}}
  #
  def create
    # add new response to db
    ulike = UserLike.new(params_create)
    ulike.user_id = @current_user.id
    if ulike.save
      #render :json => {:success => true, :response => uresponse.as_json(only: [:id, :user_id, :content_id, :response])}, :status=> :created #201
      render :json => {:success => true, :user_like => ulike.as_json}, :status=> :created #201
    else
      warden.custom_failure!
      render :json => {:success => false, :message => (ulike.errors.as_json)}, :status=> :unprocessable_entity
    end
  end

  private

  def params_create
    params.require(:params).permit(:userid_liked)
  end

end