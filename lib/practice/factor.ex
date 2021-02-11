defmodule Practice.Factor do
  def factor(x), do:
    factor(x, 2, []) |> Enum.reverse

  def factor(n, divisor, acc) when rem(n, divisor) === 0, do:
    factor(div(n, divisor), divisor, [divisor | acc])
  def factor(n, divisor, acc) when n > 1, do:
    factor(n, divisor + 1, acc)
  def factor(_, _, acc), do: acc
end
