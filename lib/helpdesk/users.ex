defmodule Helpdesk.Users do
  @moduledoc false
  use Ash.Domain

  resources do
    resource Helpdesk.Users.Ticket
  end
end
