defmodule Practice.Factors do
  def factor(x) do
    num = x;
    unless is_number(x) do
      num = parse_int(x)
      IO.inspect(num)
      IO.inspect(is_number(num))
    end
    f(num, 2, [])
    |> Enum.reverse
  end

  def parse_int(text) do
    {num, _} = Integer.parse(text)
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
