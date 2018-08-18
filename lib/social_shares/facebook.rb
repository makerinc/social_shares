module SocialShares
  class Facebook < Base
    URL = 'https://graph.facebook.com/v3.0/'

    def shares!
      response = get(URL, params: params)
      json_response = JSON.parse(response)
      sum = 0
      if json_response['engagement']
        json_response['engagement'].each do |share_type, count|
          sum += count unless share_type == 'comment_plugin_count'
        end
      end
      sum
    end

    def params
      _params = { id: checked_url, fields: 'reaction' }
      token = ENV['FACEBOOK_ACCESS_TOKEN']
      if token
        _params.merge!(access_token: token)
      end
      _params
    end
  end
end
