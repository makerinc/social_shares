module SocialShares
  class Facebook < Base
    URL = 'https://graph.facebook.com/v2.7/'

    def shares!
      response = get(URL, params: params)
      json_response = JSON.parse(response)
      sum = 0
      if json_response['share']
        json_response['share'].each do |share_type, count|
          sum += count
        end
      end
      sum
    end

    def params
      _params = { id: checked_url, fields: 'share' }
      token = ENV['FACEBOOK_ACCESS_TOKEN']
      if token 
        _params.merge!(access_token: token)        
      end
      _params
    end
  end
end
