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

    assert {:ok, _} =
             Helpdesk.Projects.fetch_ticket(project.id, ticket.id, actor: user)
  end

  test "should be able to create a project when creating a project note" do
    create_input = %{
      text: "This is a test project note",
      project: %{
        name: "Test Project"
      }
    }

    assert %Helpdesk.Projects.ProjectNote{} =
      Helpdesk.Projects.ProjectNote
      |> Ash.Changeset.for_create(:create, create_input)
      |> Ash.create!()
  end

  test "should be able to create a project when using bulk create to create a project note" do
    create_input = %{
      text: "This is a test project note",
      project: %{
        name: "Test Project"
      }
    }

    assert [%Helpdesk.Projects.ProjectNote{}] = Ash.bulk_create!([create_input], Helpdesk.Projects.ProjectNote, :create)

  end
end
