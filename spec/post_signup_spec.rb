require_relative "routes/signup"
require_relative "libs/mongo"
describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Leandro", email: "leandro@gmail.com", password: "lap.cido" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      # dado que eu tenha um novo usuario
      payload = { name: "Lucia Paiva", email: "lucia@gmail.com", password: "lap.cido" }
      MongoDB.new.remove_user(payload[:email])

      # e o email desse usuário ja foi cadastrado no sistema
      Signup.new.create(payload)

      # Quando faço uma requisição para a rota /Signup
      @result = Signup.new.create(payload)
    end
    it "deve retornar 409" do

      # Então deve retonar 409
      expect(@result.code).to eql 409
    end
    it "Deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end
  context "Nome e obrigatorio" do
    before(:all) do
      payload = { name: "", email: "lucia@gmail.com", password: "lap.cido" }
      MongoDB.new.remove_user(payload[:email])
      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end
    it "deve retornar 412" do
      expect(@result.code).to eql 412
    end
    it "Deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required name"
    end
  end
  context "Email obrigatorio" do
    before(:all) do
      payload = { name: "Lucia Paiva", email: "", password: "lap.cido" }
      MongoDB.new.remove_user(payload[:email])
      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end
    it "deve retornar 412" do
      expect(@result.code).to eql 412
    end
    it "Deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required email"
    end
  end
  context "Password Obrigatorio" do
    before(:all) do
      payload = { name: "Lucia Paiva", email: "lucia@gmail.com", password: "" }
      MongoDB.new.remove_user(payload[:email])
      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end
    it "deve retornar 412" do
      expect(@result.code).to eql 412
    end
    it "Deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required password"
    end
  end
end
