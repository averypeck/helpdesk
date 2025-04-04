defmodule HelpdeskTest do
  use ExUnit.Case
  doctest Helpdesk

  require Ash.Generator
  require Ash.Query

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Helpdesk.Repo)
  end

  test "should fetch ticket" do
    ticket = Ash.Generator.seed!(Helpdesk.Tickets.Ticket)
    project = Ash.Generator.seed!(Helpdesk.Projects.Project)

    user = Ash.Generator.seed!(Helpdesk.Accounts.User, %{projects: [project]})

    Ash.Generator.seed!(Helpdesk.Projects.Ticket, %{project: project, ticket: ticket})

    Ash.Generator.seed!(Helpdesk.Users.Ticket, %{user: user, ticket: ticket})

    project_tickets =
      Helpdesk.Projects.Ticket
      |> Ash.read!()

    dbg(project_tickets)

    assert {:ok, _} =
             Helpdesk.Projects.fetch_ticket(project.id, ticket.id, actor: user)
  end
end
