require_relative "base_api"

class Sessions < BaseApi
  # include HTTParty
  # base_uri "http://rocklov-api:3333"

  def login(payload)
    # payload = { email: email, password: pass }
    return self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
