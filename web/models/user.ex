defmodule Discuss.User do
    use Discuss.Web, :model

    schema "users" do
        field :token, :string
        field :email, :string
        field :provider, :string
        
        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:email, :provider, :token])
        |> validate_required([:email, :provider, :token])
    end
end