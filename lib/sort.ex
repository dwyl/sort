defmodule Sort do
  @moduledoc """
  The `Sort` module create a list of sort records.
  """
  alias __MODULE__
  @type t :: %Sort{id: integer(), code: String.t(), label: String.t()}
  @enforce_keys [:id, :code, :label]

  defstruct [:id, :code, :label]

  @doc """
  Returns list of the `sort` records.
  """
  @spec get() :: list(Sort.t())
  def get do
    parse_json()
    |> Enum.map(fn obj ->
      struct(Sort, id: obj["id"], code: obj["code"], label: obj["label"])
    end)
  end

  defp parse_json do
    {:ok, cwd} = File.cwd()

    # we need this `cd` to locate the file in `/deps`
    case cwd =~ "/sort" do
      true ->
        File.read!("sort.json")
        |> Jason.decode!()

      # coveralls-ignore-start

      # temporarily `cd` into `deps/sort` dir and read `sort.json` file:
      false ->
        File.cd!("deps/sort")

        data =
          File.read!("sort.json")
          |> Jason.decode!()

        # change back into the root directory
        File.cd!("../..")
        # return the decoded (parsed) JSON data
        data

        # coveralls-ignore-stop
    end
  end
end
