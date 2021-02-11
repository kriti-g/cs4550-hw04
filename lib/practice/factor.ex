defmodule Practice.Factors do
  def factor(x) do
    if is_integer(x) do
      f(x, 2, [])
      |> Enum.reverse
      |> to_string
    else
      f(parse_int(x), 2, [])
      |> Enum.reverse
      |> to_string
    end
  end

  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def f(num, div, fs) when is_integer(num) do
    res = div(num, div);
    re = rem(num, div);
    cond do
      re === 0 -> f(res, div, [div | fs])
      num > 1 -> f(num, div + 1, fs)
      true -> fs
    end
  end
end
