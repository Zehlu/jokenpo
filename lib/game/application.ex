defmodule Game.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Game.TaskSupervisor},
      {Game, []},
      Supervisor.child_spec({Task, fn -> GameServer.accept() end}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: Game.Supervisor]
    Supervisor.start_link(children, opts)
  end
end