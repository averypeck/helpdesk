defmodule Helpdesk.Accounts.User do
  @moduledoc false
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Accounts,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo(Helpdesk.Repo)
  end

  actions do
    defaults [:read]
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
