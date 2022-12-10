defmodule TimeZoneSyncBot.Commands.UpdateTimeZone do
  require Ecto.Query

  def execute(chat_id, label, new_location) do
    query =
      TimeZoneSyncBot.TimeZone
      |> Ecto.Query.where(chat_id: ^chat_id)
      |> Ecto.Query.where(label: ^label)

    case TimeZoneSyncBot.Repo.one(query) do
      nil ->
        error_messages = %{
          label: ["not found"]
        }

        {:error, error_messages}

      time_zone ->
        params = %{location: new_location}

        changeset = TimeZoneSyncBot.TimeZone.changeset(time_zone, params)

        case TimeZoneSyncBot.Repo.update(changeset) do
          {:ok, updated_time_zone} ->
            %TimeZoneSyncBot.TimeZone{
              label: updated_label,
              location: updated_location
            } = updated_time_zone

            {:ok, "#{updated_label} has been updated with #{updated_location}."}

          {:error, changeset} ->
            error_messages = TimeZoneSyncBot.Commands.Error.extract_error_messages(changeset)
            {:error, error_messages}
        end
    end
  end
end
