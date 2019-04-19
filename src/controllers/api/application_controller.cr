class API::ApplicationController < ApplicationController
  before_action do
    all do
      context.response.content_type = "application/json; charset=utf-8"
    end
  end
end
