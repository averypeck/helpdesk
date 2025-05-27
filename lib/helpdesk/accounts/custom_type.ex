defmodule Helpdesk.Accounts.CustomType do
  @moduledoc false

  use Ash.Type.NewType,
    subtype_of: :map,
    constraints: [
      fields: [
        type: [
          type: :atom
        ]
      ]
    ],
    lazy_init?: true

  use AshGraphql.Type

  @impl AshGraphql.Type
  def graphql_type(_) do
    :custom_type
  end

  @impl AshGraphql.Type
  def graphql_input_type(_) do
    :custom_type_input
  end
end
