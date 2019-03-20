class API::ApplicationController < ApplicationController
  before_action do
    all do
      context.response.content_type = "application/json"
    end
  end
end
