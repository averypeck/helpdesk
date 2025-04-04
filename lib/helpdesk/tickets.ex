defmodule Helpdesk.Tickets do
  @moduledoc false
  use Ash.Domain

  resources do
    resource Helpdesk.Tickets.Ticket
  end
end
