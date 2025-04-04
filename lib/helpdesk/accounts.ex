defmodule Helpdesk.Accounts do
  @moduledoc false
  use Ash.Domain

  resources do
    resource Helpdesk.Accounts.User
  end
end
