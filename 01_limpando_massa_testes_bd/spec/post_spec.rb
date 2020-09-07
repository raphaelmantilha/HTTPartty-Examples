describe "cadastro" do

    it "novo usuario" do
        Database.new.delete_user("me@papito.io")

        result = HTTParty.post(
            "http://192.168.99.100:3001/user", 
             body: {full_name: "Fernando Papito", email: "me@papito.io", password: "jarvis123"}.to_json,
             headers: {
                 "Content-Type" => "application/json",
             },
        )
        puts result
        expect(result.response.code).to eql "200"
    end
end