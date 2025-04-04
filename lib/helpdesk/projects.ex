defmodule Helpdesk.Projects do
  @moduledoc false
  use Ash.Domain,
    extensions: []

  alias Helpdesk.Projects.Ticket
  alias Helpdesk.Projects.Project
  alias Helpdesk.Projects.User

  resources do
    resource Ticket do
      define :fetch_ticket, action: :read, get_by: [:project_id, :ticket_id]
    end

    resource Project

    resource User
  end
end
