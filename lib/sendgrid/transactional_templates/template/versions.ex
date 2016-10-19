defmodule SendGrid.Template.Versions do
  alias __MODULE__
  alias SendGrid.Template.Version

  @spec activate(Version.t) :: Version.t | {:error, [String.t]} | {:error, String.t}
  def activate(%Version{} = version) do
    case SendGrid.post(base_url(version.template_id, version.id) <> "/activate", version, []) do
      { :ok, response = %{ status_code: status_code } } when status_code in [200,202] ->
        Version.new(response.body, :json)
      { :ok, %{ body: body } } -> { :error, body["errors"] }
      _ -> { :error, "Unable to communicate with SendGrid API." }
    end
  end

  @spec get(String.t, String.t) :: Version.t | {:error, [String.t]} | {:error, String.t}
  def get(template, version) do
    case SendGrid.get(base_url(template,version), []) do
      { :ok, response = %{ status_code: status_code } } when status_code in [200,202] ->
        Version.new(response.body, :json)
      { :ok, %{ body: body } } -> { :error, body["errors"] }
      _ -> { :error, "Unable to communicate with SendGrid API." }
    end
  end

  @spec update(Version.t) :: Version.t | {:error, [String.t]} | {:error, String.t}
  def update(%Version{} = version) do
    case SendGrid.patch(base_url(version.template_id, version.id), version, []) do
      { :ok, response = %{ status_code: status_code } } when status_code in [200,202] ->
        Version.new(response.body, :json)
      { :ok, %{ body: body } } -> { :error, body["errors"] }
      _ -> { :error, "Unable to communicate with SendGrid API." }
    end
  end

  @spec create(Version.t) :: Version.t | {:error, [String.t]} | {:error, String.t}
  def create(%Version{} = version) do
    case SendGrid.post(base_url(version.template_id), version, []) do
      { :ok, response = %{ status_code: status_code } } when status_code in [200,202] ->
        Version.new(response.body, :json)
      { :ok, %{ body: body } } -> { :error, body["errors"] }
      _ -> { :error, "Unable to communicate with SendGrid API." }
    end
  end

  @spec delete(Version.t) :: :ok | {:error, [String.t]} | {:error, String.t}
  def delete(%Version{} = version) do
    case SendGrid.delete(base_url(version.template_id, version.id), []) do
      { :ok, %{ status_code: status_code } } when status_code in [200,202] ->
        :ok
      { :ok, %{ body: body } } -> { :error, body["errors"] }
      _ -> { :error, "Unable to communicate with SendGrid API." }
    end
  end




  defp base_url(template) do
    "/v3/templates/#{template}"
  end

  defp base_url(template, version) do
    "/v3/templates/#{template}/versions/#{version}"
  end

end
