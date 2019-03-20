class API::V1::ApplicationController < API::ApplicationController
  def not_found
    {error: "Invaldi API Request"}.to_json
  end
end
