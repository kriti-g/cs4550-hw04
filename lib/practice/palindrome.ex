defmodule Practice.Palindrome do
  def palindrome?(str) do
    str == reverse_string(str)
  end

  def reverse_string(str) do
    String.to_char_list(str)
    |> Enum.reverse
    |> List.to_string
  end
end
