defmodule GeolocationTest do
  use ExUnit.Case, async: true
  doctest WorldJobs

  test "get continent by latitude and longitude" do
    new_york = {40.730610, -73.935242}
    assert Geolocation.get_continent(new_york) == :"North America"

    sao_paulo = {-23.627, -46.635}
    assert Geolocation.get_continent(sao_paulo) == :"South America"

    chengdu = {30.5812, 104.068}
    assert Geolocation.get_continent(chengdu) == :Asia

    paris = {48.856614, 2.3522219}
    assert Geolocation.get_continent(paris) == :Europe

    dakar = {14.6919, -17.4474}
    assert Geolocation.get_continent(dakar) == :Africa

    canberra = {-35.3081, 149.124}
    assert Geolocation.get_continent(canberra) == :Oceania

    concordia_station = {-75.0999996, 123.333332}
    assert Geolocation.get_continent(concordia_station) == :Antarctica
  end
end
