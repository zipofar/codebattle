defmodule Codebattle.ForbidMultipleGamesTest do
  use Codebattle.IntegrationCase

  test "User cannot create second game", %{conn: conn} do
    insert(:task)
    user = insert(:user)

    conn =
      conn
      |> put_session(:user_id, user.id)
      |> get(user_path(conn, :index))

    conn
    |> get(page_path(conn, :index))
    |> post(game_path(conn, :create))

    conn =
      conn
      |> get(page_path(conn, :index))
      |> post(game_path(conn, :create))

    assert conn.status == 302

    assert Game |> Repo.all() |> Enum.count() == 1
  end
end
