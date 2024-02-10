defmodule DemoWeb.PageController do
  use DemoWeb, :live_view

  @spec render(any()) :: none()
  def render(assigns) do
    inspect(assigns)
    assigns = assign(assigns, :page, assigns[:page] || 1)

    ~H"""
    page <%= @page %>
    <br />
    <br />
    <.link style="color: blue; text-decoration: underline" patch={"?page=#{@page+1}"}>
      goto page <%= @page + 1 %>
    </.link>
    <br />
    <br />

    <pre>
    STR:
    1. open dev console
    2. navigate to page 2
    3. use browser backward
       observe that it prints the stored user data
    4. use browser forward to get back to this page
       observe that it forgot stored user data
    </pre>
    """
  end

  def handle_params(%{"page" => page}, _url, socket) do
    socket = assign(socket, page: String.to_integer(page))
    {:noreply, socket}
  end

  def handle_params(_params, _url, socket), do: {:noreply, socket}
end
