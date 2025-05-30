defmodule Helpdesk.Projects.Project do
  @moduledoc false

  use Ash.Resource,
    domain: Helpdesk.Projects,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "projects"
    repo(Helpdesk.Repo)
  end

  actions do
    defaults [:read]

    create :create do
      primary? true
      accept [:*]
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string do
      allow_nil? false
      constraints min_length: 1
      public? true
    end
  end

  relationships do
    has_many :tickets, Helpdesk.Projects.Ticket do
      source_attribute :id
      destination_attribute :project_id
      public? true
    end

    many_to_many :users, Helpdesk.Accounts.User do
      through Helpdesk.Projects.User
      source_attribute :id
      source_attribute_on_join_resource :project_id
      destination_attribute_on_join_resource :user_id
      destination_attribute :id
    end

    has_many :project_notes, Helpdesk.Projects.ProjectNote
  end
end
