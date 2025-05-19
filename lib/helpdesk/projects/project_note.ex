defmodule Helpdesk.Projects.ProjectNote do
  @moduledoc false

  use Ash.Resource,
    domain: Helpdesk.Projects,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "project_notes"
    repo(Helpdesk.Repo)
  end

  actions do
    defaults [:read]

    create :create do
      accept [:*]
      argument :project, :map, allow_nil?: false
      change manage_relationship(:project, type: :create)
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :text, :string, public?: true
  end

  relationships do
    belongs_to :project, Helpdesk.Projects.Project, allow_nil?: false, attribute_writable?: true, public?: true
  end
end
