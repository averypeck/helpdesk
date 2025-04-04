defmodule Helpdesk.Projects.Ticket.Checks.IsUser do
  @moduledoc false
  use Ash.Policy.FilterCheck

  alias Ash.Policy.FilterCheck

  @impl Ash.Policy.Check
  def describe(_options) do
    ""
  end

  @impl FilterCheck
  def filter(_actor, _context, _options) do
    expr(
      exists(
        users.tickets,
        ticket_id == parent(ticket_id) and
          user_id == ^actor(:id)
      )
    )
  end
end
