describe "delete" do

    context "quando deleto um usuário cadastrado" do
        let(:user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.remove(token, user.id) }
     
        it "deve retornar 204" do
            expect(result.response.code).to eql "204"    
        end
    end

    context "quando o id do usuário não existe" do
        let(:user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.remove(token, "0") }
        
        it "deve retornar 404" do
            expect(result.response.code).to eql "404"    
        end
    end

    context "quando id do usuário é incorreto" do
        let(:user) { build(:registered_user) }
        let(:token) { ApiUser.token(user.email, user.password) }
        let(:result) { ApiUser.remove(token, "abc123") }
        
        it "deve retornar 412" do
            expect(result.response.code).to eql "412"    
        end
    
    end
end