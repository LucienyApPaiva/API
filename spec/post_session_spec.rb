require_relative "routes/sessions"
require_relative "helpers"

# DRY Don`t Repeat Yourself => Não se repita

describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "gaelpaiva@gmail.com", password: "lap.cido" }
      @result = Sessions.new.login(payload)
      #   payload = { email: "gaelpaiva@gmail.com", password: "lap.cido" }

      #   @result = HTTParty.post(
      #     "http://rocklov-api:3333/sessions",
      #     body: payload.to_json,
      #     headers: {
      #       "Content-Type": "application/json",
      #     },
      #   )

      #   puts "teste"
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  #   examples = [
  #     {
  #       title: "senha incorreta",
  #       payload: { email: "gaelpaiva@gmail.com", password: "123456" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },

  #     {
  #       title: "usuario não existe",
  #       payload: { email: "404@gmail.com", password: "lap.cido" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },
  #     {
  #       title: "email em branco",
  #       payload: { email: "", password: "lap.cido" },
  #       code: 412,
  #       error: "required email",
  #     },
  #     {
  #       title: "sem o campo email",
  #       payload: { password: "lap.cido" },
  #       code: 412,
  #       error: "required email",
  #     },
  #     {
  #       title: "senha em branco",
  #       payload: { email: "gaelpaiva@gmail.com", password: "" },
  #       code: 412,
  #       error: "required password",
  #     },
  #     {
  #       title: "sem o campo senha",
  #       payload: { email: "gaelpaiva@gmail.com" },
  #       code: 412,
  #       error: "required password",
  #     },
  #   ]

  #   puts examples.to_json

#   examples = YAML.load(File.read(Dir.pwd + "/spec/fixtures/login.yml"), symbolize_names: true)
  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        # payload = { email: "gaelpaiva@gmail.com", password: "123456" }
        # @result = Sessions.new.login(payload)]
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        # expect(@result.code).to eql 401
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuário" do
        # expect(@result.parsed_response["error"]).to eql "Unauthorized"
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end

  #   it "Login com sucesso" do
  # payload = { email: "gaelpaiva@gmail.com", password: "lap.cido" }

  # result = HTTParty.post(
  #   "http://rocklov-api:3333/sessions",
  #   body: payload.to_json,
  #   headers: {
  #     "Content-Type": "application/json",
  #   },
  # )

  # expect(result.code).to eql 200
  # expect(result.parsed_response["_id"].length).to eql 24

  # puts result.parsed_response["_id"]
  # puts result.parsed_response.class
  #   end
end

# context "senha invalida" do
#   before(:all) do
#     payload = { email: "gaelpaiva@gmail.com", password: "123456" }
#     @result = Sessions.new.login(payload)
#   end

#   it "valida status code" do
#     expect(@result.code).to eql 401
#   end

#   it "valida id do usuário" do
#     expect(@result.parsed_response["error"]).to eql "Unauthorized"
#   end
# end

# context "Usuário não existente" do
#   before(:all) do
#     payload = { email: "404@gmail.com", password: "123456" }
#     @result = Sessions.new.login(payload)
#   end

#   it "valida status code" do
#     expect(@result.code).to eql 401
#   end

#   it "valida id do usuário" do
#     expect(@result.parsed_response["error"]).to eql "Unauthorized"
#   end
# end

# context "Email em Branco" do
#   before(:all) do
#     @result = Sessions.new.login("", "lap.cido")
#   end

#   it "valida status code" do
#     expect(@result.code).to eql 412
#   end

#   it "valida id do usuário" do
#     expect(@result.parsed_response["error"]).to eql "required email"
#   end
# end

# context "Sem o campo email" do
#   before(:all) do
#     @result = Sessions.new.login("", "lap.cido")
#   end

#   it "valida status code" do
#     expect(@result.code).to eql 412
#   end

#   it "valida id do usuário" do
#     expect(@result.parsed_response["error"]).to eql "required email"
#   end
# end
