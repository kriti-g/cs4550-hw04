defmodule Practice.Factor do
  def factor(x) do
    f(x, 2, [])
    |> Enum.reverse
  end

  def f(x, div fs) do
    cond do
      rem(x, div) === 0 -> f(div(x, div), div, [div | fs])
      x > 1 -> f(x, div + 1, fs)
      true -> fs
    end
  end

end
