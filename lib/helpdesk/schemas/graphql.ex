defmodule Helpdesk.Schemas.Graphql do
  @moduledoc false
  use Absinthe.Schema

  use AshGraphql,
    domains: [
      Helpdesk.Accounts
    ]

  query do
  end

  mutation do
  end
end
