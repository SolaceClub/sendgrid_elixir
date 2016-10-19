defmodule SendGrid.Template do
  @moduledoc """
    Module to interact with transaction email templates.
  """
  alias __MODULE__

  defstruct [
    id: nil,
    name: nil,
    versions: nil
  ]

  @type t :: %Template{
    id: String.t,
    name: String.t,
    versions: [Versions.t]
  }

  @spec new(Map.t, :json) :: Template.t
  def new(json, :json) do
    # versions.
    versions = case json["versions"] do
      nil -> []
      versions when is_list(versions) ->
        for version <- versions do
          SendGrid.Template.Version.new(version, :json)
        end
    end

    %Template{
      id: json["id"],
      name: json["name"],
      versions: versions
    }
  end

end

defimpl Poison.Encoder, for: SendGrid.Template do
  def encode(entity, options) do
    %{
      id: entity.id,
      name: entity.name,
      versions: entity.versions
    } |>  Poison.Encoder.encode(options)
  end
end
