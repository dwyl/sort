defmodule SortTest do
  use ExUnit.Case
  doctest Sort

  test "Sort.get/0 returns the list of sort records" do
    list = Sort.get() |> dbg
    # sample sort we know is in the list
    sample = %Sort{
      code: "DESC",
      id: 1,
      label: "Newest first"
    }

    assert Enum.member?(list, sample)
  end
end
