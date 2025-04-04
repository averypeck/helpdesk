defmodule Helpdesk.Users.Ticket do
  @moduledoc false
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Users,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "user_tickets"
    repo(Helpdesk.Repo)
  end

  # code_interface do
  #   define :read_by_id, action: :read, get_by: :id
  # end

  actions do
    defaults [:read]
  end

  attributes do
    uuid_primary_key :id
  end

  relationships do
    belongs_to :ticket, Helpdesk.Tickets.Ticket,
      primary_key?: true,
      allow_nil?: false,
      public?: true,
      source_attribute: :ticket_id

    belongs_to :user, Helpdesk.Accounts.User,
      primary_key?: true,
      allow_nil?: false,
      public?: true
  end
end
