defmodule Practice.Factors do
  def factor(x) do
    x = parse_float(x)
    f(x, 2, [])
    |> Enum.reverse
  end
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end
  def f(x, div, fs) do
    res = div(x, div);
    re = rem(x, div);
    cond do
      re === 0 -> f(res, div, [div | fs])
      x > 1 -> f(x, div + 1, fs)
      true -> fs
    end
  end
end
