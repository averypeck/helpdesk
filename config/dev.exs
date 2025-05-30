import Config

# Configure your database
config :helpdesk, Helpdesk.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "helpdesk_dev",
  port: 5442,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
