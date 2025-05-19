defmodule Helpdesk.Repo.Migrations.AddProjectNoteTable do
  use Ecto.Migration

  def change do
    create table(:project_notes, primary_key: false) do
      add(:id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true)
      add :text, :string
      add(
        :project_id,
        references(:projects,
          column: :id,
          type: :uuid,
          prefix: "public"
        ),
        null: false
      )
    end

    alter table(:projects) do
      add :name, :text
    end
  end
end
