defmodule Practice.Factors do
  def factor(x) do
    num = x;
    unless is_number(num) do
      num = parse_int(x)
    end
    f(num, 2, [])
    |> Enum.reverse
  end

  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def f(num, div, fs) do
    res = div(num, div);
    re = rem(num, div);
    cond do
      re === 0 -> f(res, div, [div | fs])
      num > 1 -> f(num, div + 1, fs)
      true -> fs
    end
  end
end
