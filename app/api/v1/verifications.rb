module Api
  module V1
    class Verifications < Grape::API
      version 'v1'
      format :json
      content_type :json, 'application/json'
      prefix :api

      params do
        requires :campaign_list, type: Array, desc: 'list of campaigns'
      end

      desc 'Creates Verification and returns a list of reports or empty list'
      post :verify do
        @verification = Verification.create!(campaign_list: params[:campaign_list])
        @verification.perform!
      end

      add_swagger_documentation(
          api_version: 'v1',
          hide_documentation_path: true,
          info: {
              title: 'AdMatcher',
              description: 'Simple solution to verify ads'
          }
      )
    end
  end
end