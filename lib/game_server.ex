defmodule GameServer do
  require Logger

  def accept(port \\ 4040) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Aceito conexões na porta #{port}")

    loop_accept(socket)
  end

  defp loop_accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info("Cliente conectado: #{inspect(client)}")

    {:ok, pid} = Task.Supervisor.start_child(Game.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_accept(socket)
  end

  defp serve(socket) do
    with {:ok, data} <- :gen_tcp.recv(socket, 0) do
      response = process_request(data)
      :gen_tcp.send(socket, response)
      serve(socket)
    else
      {:error, _} -> :gen_tcp.close(socket)
    end
  end

  defp process_request(request) do
    choice = String.trim(String.upcase(request))
    Logger.info("Escolha recebida do cliente: #{choice}")

    case Game.play(choice) do
      {:tie, computer_choice} -> "Empate! Computador escolheu: #{computer_choice}\r\n"
      {:win, computer_choice} -> "Você ganhou! Computador escolheu: #{computer_choice}\r\n"
      {:loss, computer_choice} -> "Você perdeu! Computador escolheu: #{computer_choice}\r\n"
      _ -> "Comando inválido\r\n"
    end

  end
end