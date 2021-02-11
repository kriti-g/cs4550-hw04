defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
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

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    #|> Enum.map(tag_token)
    #|> convert
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
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


  def convert(exprlst) do
    output = []
    stack = []

    process = fn (token) ->

      if is_rator(token) do
        if stack == [] do
          [token | stack]
        else
          compari = compare(token, hd stack)
          case compari do
            1 -> [token | stack]
            0 -> output = output ++ [hd stack]; stack = stack -- [hd stack]; [token | stack];
            -1 -> output = output ++ [hd stack]; stack = stack -- [hd stack]; [token | stack]; process(token);
          end
        end
      else
        output ++ token
      end
    end
    Enum.each(exprlst, process.(token))
    Enum.each(stack, fn(token) -> output = output ++ [hd stack]; stack = stack -- [hd stack]; end)
  end
end
