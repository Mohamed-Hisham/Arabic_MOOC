class Users::Devise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in(:user, @user)
        redirect_to after_sign_in_path_for(@user)
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        new_user = User.create(email: @user.email,
                              user_name: @user.user_name,
                              password: @user.password,
                              first_name: @user.first_name,
                              last_name: @user.last_name,
                              gender: @user.gender,
                              avatar: @user.avatar,
                              dob: @user.dob,
                              provider: @user.provider,
                              uid: @user.uid,
                              confirmed_at: DateTime.now)
        resource_saved = new_user.save
        sign_in new_user
      end
    end
end