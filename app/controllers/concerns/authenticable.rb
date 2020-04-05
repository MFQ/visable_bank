
module Authenticable
  def current_user
    return @current_user if @current_user
    begin
      header = request.headers['Authorization']
      decoded = JsonWebToken.decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue
      return nil
    end
  end

  def is_authentication
    render json: { errors: "Unauthorized" }, status: :unauthorized unless current_user
  end
end