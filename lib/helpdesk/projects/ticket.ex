defmodule Helpdesk.Projects.Ticket do
  @moduledoc false
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Projects,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "project_tickets"
    repo(Helpdesk.Repo)
  end

  actions do
    defaults [:read]
  end

  policies do
    policy action(:read) do
      authorize_if Helpdesk.Projects.Ticket.Checks.IsUser
    end
  end

  attributes do
    uuid_primary_key :id

    timestamps()
  end

  relationships do
    belongs_to :ticket, Helpdesk.Tickets.Ticket,
      allow_nil?: false,
      source_attribute: :ticket_id,
      destination_attribute: :id,
      attribute_public?: true

    belongs_to :project, Helpdesk.Projects.Project, allow_nil?: false

    has_many :user_tickets, Helpdesk.Users.Ticket,
      source_attribute: :ticket_id,
      destination_attribute: :ticket_id

    many_to_many :users, Helpdesk.Accounts.User do
      through Helpdesk.Projects.User
      source_attribute :project_id
      source_attribute_on_join_resource :project_id
      destination_attribute_on_join_resource :user_id
      destination_attribute :id
    end
  end
end
