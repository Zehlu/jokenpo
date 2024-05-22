defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "game play" do
    assert {:ok, :tie, _} = Game.play("PEDRA")
    assert {:ok, :win, _} = Game.play("PEDRA")
    assert {:ok, :loss, _} = Game.play("PEDRA")
  end
end