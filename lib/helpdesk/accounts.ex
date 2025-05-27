defmodule Helpdesk.Accounts do
  @moduledoc false
  use Ash.Domain, extensions: [AshGraphql.Domain]

  resources do
    resource Helpdesk.Accounts.User
  end
end
