describe "post" do

    context "quando cadastro um novo usuário" do
        # before do 
        #     new_user = build(:user).to_hash     
        #     @result = ApiUser.save(new_user)
        # end

        let(:new_user) { build(:user).to_hash }
        let(:result) { ApiUser.save(new_user) }
        #outro jeito: let(:result) { ApiUser.save(build(:user).to_hash) }

        it "então deve retornar 200" do
            expect(result.response.code).to eql "200"
        end
    end

    context "quando é fornecido e-mail duplicado" do

        before do 
            @new_user = build(:registered_user).to_hash     
            @result = ApiUser.save(@new_user) 
        end

        it "então deve retornar 409" do
            expect(@result.response.code).to eql "409"
        end
    
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address."
        end
    
    end

    context "quando é inserido e-mail inválido" do
        before do
            @new_user = build(:user_wrong_email).to_hash
            @result = ApiUser.save(@new_user)
        end

        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end

        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Oops. You entered a wrong email."
        end
    end

    context "quando nome estiver vazio" do
        before do
            @new_user = build(:empty_name_user).to_hash
            @result = ApiUser.save(@new_user)
        end
        
        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end
        
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed"
        end
    end

    context "quando e-mail estiver vazio" do
        before do
            @new_user = build(:empty_email_user).to_hash
            @result = ApiUser.save(@new_user)
        end
        
        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end
        
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Validation notEmpty on email failed"
        end
    end

    context "quando e-mail estiver vazio" do
        before do
            @new_user = build(:empty_password_user).to_hash
            @result = ApiUser.save(@new_user)
        end
        
        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end
        
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Validation notEmpty on password failed"
        end
    end

    context "quando full_name é nulo" do
        before do
            @new_user = build(:null_full_name).to_hash
            @result = ApiUser.save(@new_user)
        end
        
        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end
        
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Users.full_name cannot be null"
        end
    end

    context "quando e-mail é nulo" do
        before do
            @new_user = build(:null_email).to_hash
            @result = ApiUser.save(@new_user)
        end
        
        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end
        
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Users.email cannot be null"
        end
    end

    context "quando password é nulo" do
        before do
            @new_user = build(:null_password).to_hash
            @result = ApiUser.save(@new_user)
        end
        
        it "então deve retornar 412" do
            expect(@result.response.code).to eql "412"
        end
        
        it "então a mensagem de erro deve ser exibida" do
            expect(@result.parsed_response["msg"]).to eql "Users.password cannot be null"
        end
    end
end