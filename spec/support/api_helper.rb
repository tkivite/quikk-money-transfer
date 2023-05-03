

module ApiHelper
    def headers(token)
        { HTTP_AUTHORIZATION: "Bearer #{token}"}
    end

    def get_request(url, token)
        get url, headers: headers(token)
    end

    def post_request(url, token, params)
        post url, params: params, headers: headers(token)
    end

    def log_in(user)
        post '/auth/login', params: { email: user.email, password: user.password }
        @token = JSON.parse(response.body)['token']
    end

    def json_body
      JSON.parse(response.body)
    end
end