defmodule Game do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, %{wins: 0, losses: 0, ties: 0}}
  end

  def play(choice) do
    GenServer.call(__MODULE__, {:play, choice})
  end

  @impl true
  def handle_call({:play, player_choice}, _from, state) do
    computer_choice = Enum.random(["PEDRA", "PAPEL", "TESOURA"])
    Logger.info("Escolha recebida do computador: #{computer_choice}")
    
    
    result = determine_winner(player_choice, computer_choice)
    new_state = update_state(result, state)

    Logger.info("Resultado: #{result}")

    {:reply, {result, computer_choice}, new_state}
  end

  defp determine_winner(player, computer) do
    case {player, computer} do
      {x, x} -> :tie
      {"PEDRA", "TESOURA"} -> :win
      {"TESOURA", "PAPEL"} -> :win
      {"PAPEL", "PEDRA"} -> :win
      _ -> :loss
    end
  end

  defp update_state(:win, state) do
    %{state | wins: state.wins + 1}
  end

  defp update_state(:loss, state) do
    %{state | losses: state.losses + 1}
  end

  defp update_state(:tie, state) do
    %{state | ties: state.ties + 1}
  end
end