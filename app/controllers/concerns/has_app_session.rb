module HasAppSession

  def establish_app_session
    # Find the app - do secret based security here later
    params.permit(:api_key)
    app = App.find_by_api_key(params[:api_key])
    unless app
      render status: 400, text: "Invalid API Key"
      return
    end

    # Find or create the app instance - (app, device, user) tuple
    aip = app_instance_params
    unless aip
      render status: 400, text: "Invalid app instance parameters"
      return
    end

    app_instance = AppInstance.find_or_create_for_client!(app, aip[:device_type], aip[:device_id], aip[:app_user_name])
    if aip[:app_user]
      app_user = app_instance.app_user.find_or_initialize
      app_user.update_attributes(aip[:app_user])
      app_user.save
    end

    # Find or establish a session
    params.permit(:timestamp)
    device_time = Time.parse(params[:timestamp])
    app_session = AppSession.find_and_update_or_establish_session!(app_instance, device_time)
  end

  def app_instance_params
    params.require(:app_instance).permit(
      :device_type,
      :device_id,
      :app_user_name,
      :app_user => [
        :first_name,
        :last_name,
        :email
      ]
    )
  end
end
