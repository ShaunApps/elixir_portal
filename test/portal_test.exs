defmodule PortalTest do
  use ExUnit.Case
  doctest Portal

  setup_all do
    portal1 = Portal.shoot(:orange)
    portal2 = Portal.shoot(:blue)
    portal = Portal.transfer(:orange, :blue, [1,2,3,4])
    {:ok, portal: portal, portal1: portal1, portal2: portal2}
  end


  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Portal.shoot creates portal", state do
    assert state[:portal1]
    assert state[:portal2]
    assert state[:portal]
  end

  test "Portal.transfer containts data", state do
    assert Portal.Door.get(:orange) == [4,3,2,1]
  end

  test "Pushing right pops off door right and puts in door left", state do
    Portal.push_right(state[:portal])
    assert Portal.Door.get(:orange) == [3, 2, 1]
    assert Portal.Door.get(:blue) == [4]
    Portal.push_left(state[:portal])
    assert Portal.Door.get(:orange) == [4,3,2,1]
    assert Portal.Door.get(:blue) == []
  end
end
