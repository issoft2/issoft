defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel
    alias Discuss.{Topic, Comment}
    def join("comments:" <> topic_id, _params, socket) do
        topic_id = String.to_integer(topic_id)
        topic = Topic
        |> Repo.get(topic_id)
        |> Repo.preload(comments: [:user]) # load comments foe each topic and load the associate user

        {:ok, %{comments:  topic.comments}, assign(socket, :topic, topic)} # Push the topic and the associated comments backt to client
    end

    def handle_in(name, %{"content" => content}, socket) do
        topic = socket.assigns.topic
        user_id = socket.assigns.user_id
        changeset = topic
        |> build_assoc(:comments, user_id: user_id)
        |> Comment.changeset(%{content: content})

        case Repo.insert(changeset) do
            {:ok, comment} -> 
                broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment}) # to broadcast event ot javascript app
                {:reply, :ok, socket}
                {:error, _reason} ->
                    {:reply, {:error, %{errors: changeset}}, socket}
        end
    end
end