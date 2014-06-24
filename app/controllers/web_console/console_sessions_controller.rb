require_dependency 'web_console/application_controller'

module WebConsole
  class ConsoleSessionsController < ApplicationController
    include ActionController::Live

    rescue_from ConsoleSession::Unavailable do |exception|
      render json: exception, status: :gone
    end

    rescue_from ConsoleSession::Invalid do |exception|
      render json: exception, status: :unprocessable_entity
    end

    def index
      if params[:id]
        @console_session = ConsoleSession.find(params[:id])
        5.times {
          response.stream.write "hello world\n"
          sleep 2
        }
        response.stream.close
      else
        @console_session = ConsoleSession.create
      end
    end

    def input
      @console_session = ConsoleSession.find(params[:id])
      @console_session.send_input(console_session_params[:input])

      render nothing: true
    end

    def configuration
      @console_session = ConsoleSession.find(params[:id])
      @console_session.configure(console_session_params)

      render nothing: true
    end

    def pending_output
      @console_session = ConsoleSession.find(params[:id])

      render json: { output: @console_session.pending_output }
    end

    private

      def console_session_params
        params.permit(:id, :input, :width, :height)
      end
  end
end
