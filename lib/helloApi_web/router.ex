defmodule HelloApiWeb.Router do
  alias HelloApiWeb.PostController
  alias HelloApiWeb.UserController
  use HelloApiWeb, :router
  alias HelloApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1" do
    pipe_through :api

    get "/post", PostController, :get_all
    get "/post/:id", PostController, :get_one
    post "/post/create", PostController, :create
    delete "/post/:id", PostController, :delete
    put "/post/:id", PostController, :update

    # User authentication
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  # Authenticated routes
  scope "/api/v1" do
    pipe_through [:api, :jwt_authenticated]

    get "/me", UserController, :show
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: HelloApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
