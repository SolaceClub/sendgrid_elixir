defmodule SendGrid.Template.Version do
  @moduledoc """
    Module to interact with transaction email template versions.
  """
  alias __MODULE__

  defstruct [
    id: nil,
    template_id: nil,
    active: nil,
    name: nil,
    html_content: nil,
    plain_content: nil,
    subject: nil,
    updated_at: nil
  ]

  @type t :: %Version{
    id: String.t,
    template_id: String.t,
    active: nil,
    name: String.t,
    html_content: String.t,
    plain_content: String.t,
    subject: String.t,
    updated_at: String.t # Should be converted to unix epoch or Timex
  }

  @spec new(Map.t, :json) :: Version.t
  def new(json, :json) do
    %Version{
      id: json["id"],
      template_id: json["template_id"],
      active: json["active"] == 1,
      name: json["name"],
      subject: json["subject"],
      updated_at: json["updated_at"],

      # content only returned when specifically fetching entry by id. Will be null otherwise.
      html_content: json["html_content"],
      plain_content: json["plain_content"]
    }
  end
end



defimpl Poison.Encoder, for: SendGrid.Version do
  @active_status %{true => 1, false => 0}

  def encode(entity, options) do
    %{
      id: entity.id,
      template_id: entity.template_id,
      active: @active_status[entity.active],
      name: entity.name,
      subject: entity.subject,
      updated_at: entity.updated_at,
      html_content: entity.html_content,
      plain_content: entity.plain_content
    } |>  Poison.Encoder.encode(options)
  end
end
