defmodule Helpdesk.Tickets.Ticket do
  @moduledoc false
  use Ash.Resource,
    otp_app: :helpdesk,
    data_layer: AshPostgres.DataLayer,
    domain: Helpdesk.Tickets

  alias Helpdesk.Projects
  alias Helpdesk.Users

  postgres do
    table "tickets"
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
      through Projects.Ticket
    end

    many_to_many :users, Helpdesk.Accounts.User do
      through Users.Ticket
    end
  end
end
