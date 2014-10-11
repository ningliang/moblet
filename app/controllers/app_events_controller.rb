class AppEventsController < ApplicationController

  include HasAppSession

  def create
    AppEvent.transaction do
      @app_session = establish_app_session
      return unless @app_session

      event_params = params.require(:app_event).permit(:name, :params)
      event_params[:params] = event_params[:params].to_json

      params.permit(:timestamp)
      device_time = Time.parse(params[:timestamp])

      AppEvent.create!(event_params.merge(
        app_session: @app_session,
        device_time: device_time
      ))

      render status: 200, nothing: true
    end
  end

end
