defmodule SendGrid.TransactionalTemplates.Test do
  @moduledoc """
    Module to test Transational Template CRUD. Not this module requires that api key has read/write/update/delete permissions for templates and versions.
  """
  use ExUnit.Case, async: true
  doctest SendGrid.Templates, import: true
  doctest SendGrid.Template, import: true
  doctest SendGrid.Template.Version, import: true

  alias SendGrid.Templates
  alias SendGrid.Template
  alias SendGrid.Template.Versions
  alias SendGrid.Template.Version

  @tag :templates
  test "fetch templates" do
    actual = Templates.list()
    assert is_list(actual)
  end

  @tag :templates
  test "template crud" do
    # Note Better fixture management needed to avoid orphaned elements.
    # Note I'm not a fan of multi asserts per test but it simplifies fixture management for now.

    # Create Template
    new_template = Templates.create(%Template{name: "TestTemplate"})
    assert new_template.id != :nil

    # Update Template
    _updated_template = Templates.update(%Template{new_template| name: "UpdatedTemplateName"})

    # Read Template
    read_template = Templates.get(new_template.id)
    assert read_template.name == "UpdatedTemplateName"

    # Delete Template
    Templates.delete(new_template)
    {:error, _} = Templates.get(new_template.id)

  end

  @tag :templates
  test "template.version crud" do
    # Note Better fixture management needed to avoid orphaned elements.
    # Note I'm not a fan of multi asserts per test but it simplifies fixture management for now.

    # Create Template
    new_template = Templates.create(%Template{name: "TestTemplate"})
    template_id = new_template.id
    assert template_id != :nil

    # Create Version
    new_version = Versions.create(%Version{name: "TestVersion", template_id: template_id})
    assert new_version.id != :nil

    # Update Version
    updated_version = Versions.update(%Version{new_version| name: "UpdatedTestVersion"})

    # Get Version
    read_version = Versions.get(updated_version.template_id, updated_version.id)
    assert read_version.name == "UpdatedTestVersion"

    # Delete Version & Confirm
    delete_version = Versions.delete(read_version)
    assert delete_version == :ok
    {:error, _details} = Versions.get(new_version.template_id, new_version.id)

    Templates.delete(new_template)
    {:error, _} = Templates.get(new_template.id)
  end

end
