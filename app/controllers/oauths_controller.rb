class OauthsController < ApplicationController

  skip_before_action :authenticate_request, only: [:oauth, :callback]

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      token = JsonWebToken.encode({user_id: @user.id})
      render json: {success: true, token: token}
    else
      @user = save_user(provider)
      token = JsonWebToken.encode({user_id: @user.id})
      render json: {success: true, token: token}
    end
  end

  private

  def save_user(provider)
    user = create_from(provider)
    user.fb_access_token = @access_token.token
    user.save
    user
  end
end
