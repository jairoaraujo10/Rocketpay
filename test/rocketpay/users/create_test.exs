defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Name",
        password: "123456",
        nickname: "nickname",
        email: "email@mail.com",
        age: 18
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{
        name: "Name",
        age: 18,
        id: ^user_id
      } = user
    end

    test "when there are invalid params are valid, returns an user" do
      params = %{
        name: "Name",
        nickname: "nickname",
        email: "email@mail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
