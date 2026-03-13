class ErrorsController < ApplicationController
  layout "application"

  def not_found
    render "errors/404", status: 404
  end

  def forbidden
    render "errors/403", status: 403
  end

  def not_acceptable
    render "errors/406", status: 406
  end

  def unprocessable
    render "errors/422", status: 422
  end

  def internal
    render "errors/500", status: 500
  end

  def service_unavailable
    render "errors/503", status: 503
  end
end