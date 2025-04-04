defmodule Helpdesk.Projects.User do
  @moduledoc false
  use Ash.Resource,
    otp_app: :helpdesk,
    domain: Helpdesk.Projects,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "project_users"
    repo(Helpdesk.Repo)
  end

  actions do
    defaults [:read]
  end

  attributes do
  end

  relationships do
    belongs_to :user, Helpdesk.Accounts.User do
      primary_key? true
      allow_nil? false
      destination_attribute :id
      source_attribute :user_id
    end

    belongs_to :project, Helpdesk.Projects.Project do
      primary_key? true
      allow_nil? false
      destination_attribute :id
      source_attribute :project_id
    end
  end
end
