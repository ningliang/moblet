class AppCapturesController < ApplicationController

  include HasAppSession

  def create
    AppCapture.transaction do
      @app_session = establish_app_session
      return unless @app_session

      capture_params = params.require(:app_capture).permit(
        :s3_bucket, :s3_capture_key, :s3_thumbnail_key,
        :width, :height, :thumbnail_width, :thumbnail_height
      )

      params.permit(:timestamp)
      device_time = Time.parse(params[:timestamp])

      AppCapture.create!(capture_params.merge(
        app_session: @app_session,
        device_time: device_time
      ))

      render status: 200, nothing: true
    end
  end

end
