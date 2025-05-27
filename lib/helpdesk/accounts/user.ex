defmodule Helpdesk.Accounts.User do
  @moduledoc false
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :user
    queries do
      get :get_user, :read
    end
    mutations []
  end

  postgres do
    table "users"
    repo(Helpdesk.Repo)
  end

  actions do
    defaults [:read]

    action :test_custom_type, {:array, Helpdesk.Accounts.CustomType} do
      argument :test, :string

      run fn _action_name, _changes ->
        {:ok, %{result: "test"}}
      end
    end
  end

  attributes do
    uuid_primary_key :id
  end

  relationships do
    many_to_many :projects, Helpdesk.Projects.Project do
      through Helpdesk.Projects.User
    end

    has_many :tickets, Helpdesk.Users.Ticket do
      source_attribute :id
      destination_attribute :user_id
    end
  end
end
