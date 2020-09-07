describe "get" do

    context "quando um usuário é registrado" do
        
        let(:user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.find(token, user.id) }
        let(:user_data) { Database.new.find_user(user.email) }

        it "deve retornar os dados corretos" do
            expect(result.response.code).to eql "200"    
            expect(result.parsed_response["full_name"]).to eql user_data["full_name"]
            expect(result.parsed_response["password"]).to eql user_data["password"]
            expect(result.parsed_response["email"]).to eql user_data["email"]
            expect(Time.parse(result.parsed_response["createdAt"])).to eql Time.parse(user_data["created_at"])
            expect(Time.parse(result.parsed_response["updatedAt"])).to eql Time.parse(user_data["updated_at"])
        end
    end

    context "quando usuário não existe" do
        let(:user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.find(token, "0") }
        
        it "deve retornar 404" do
            expect(result.response.code).to eql "404"    
        end
    end

    context "quando id é inválido" do
        let(:user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.find(token, "abc123") }
        
        it "deve retornar 412" do
            expect(result.response.code).to eql "412"    
        end
    end

    context "quando se pesquisa id diferente do id do usuário que está logado" do
        let(:user) { build(:registered_user) }
        let(:other_user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.find(token, other_user.id) }
        
        it "deve retornar 401" do
            expect(result.response.code).to eql "401"    
        end
    end
end