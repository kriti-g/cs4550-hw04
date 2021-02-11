defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(tag_token)
    |> convert
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def tag_token(token) do
    if is_rator(token) do
      {:op, token}
    else
      {:num, parse_float(token)}
    end
  end

  def is_rator(token) do
    token == "+" || token == "-" || token == "/" || token == "*"
  end

  def convert(exprlst) do
    output = []
    stack = []

    defp process(token) do
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

    Enum.each(exprlst, process(token))
    Enum.each(stack, fn(token) -> output = output ++ [hd stack]; stack = stack -- [hd stack]; end)

  end
end
