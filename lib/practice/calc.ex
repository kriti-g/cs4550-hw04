defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(tag_token)
    # |> convert
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def is_rator(token) do
    token == "+" || token == "-" || token == "/" || token == "*"
  end

  def tag_token(token) do
    if is_rator(token) do
      {:op, token}
    else
      {:num, parse_float(token)}
    end
  end

  def compare(token1, token2) do
    convert = fn(tk) ->
      if tk == "*" || tk == "/" do
        2
      else
        1
      end
    end
    num1 = convert.(token1)
    num2 = convert.(token2)
    cond do
      num1 < num2 -> -1
      num1 == num2 -> 0
      num1 > num2 -> 1
    end
  end

end
