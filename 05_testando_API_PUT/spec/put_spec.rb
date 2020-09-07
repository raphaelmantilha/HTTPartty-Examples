describe "put" do

    context "quando tenho um usuário cadastrado" do
        before(:all) do
            original_user = build(:registered_user)
            token = ApiUser.token(original_user.email, original_user.password)
            @new_user = build(:user)
            @result_put = ApiUser.update(token, original_user.id,@new_user.to_hash)      
            @result_get = ApiUser.find(token, original_user.id)
        end

        it "deve retornar dados corretos" do
            expect(@result_put.response.code).to eql "200"
            expect(@result_get.parsed_response["full_name"]).to eql @new_user.full_name
            expect(@result_get.parsed_response["email"]).to eql @new_user.email
        end
    end
end