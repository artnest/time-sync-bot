defmodule TimeZoneSyncBot.OutputTest do
  use ExUnit.Case, async: true

  test "creates a formatted string of time zones" do
    time_zones = [
      %TimeZone{label: "Haifa", location: "Asia/Tel_Aviv"},
      %TimeZone{label: "Warsaw", location: "Europe/Warsaw"}
    ]

    output = """
             <b>Haifa</b>: Asia/Tel_Aviv
             <b>Warsaw</b>: Europe/Warsaw
             """

    assert TimeZoneSyncBot.Output.create_time_zones_output(time_zones) == output
  end
end
