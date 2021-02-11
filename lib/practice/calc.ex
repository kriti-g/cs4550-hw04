defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    tag_token = fn(token) ->
      if token == "+" || token == "-" || token == "/" || token == "*" do
        {:op, token}
      else
        {:num, parse_float(token)}
      end
    end
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(tag_token)
    |> convert
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
    num1 = convert.(Kernel.elem(token1, 1))
    num2 = convert.(Kernel.elem(token2, 1))
    cond do
      num1 < num2 -> -1
      num1 == num2 -> 0
      num1 > num2 -> 1
    end
  end



  def convert(exprlst) do
    output = []
    stack = []
    output = convertStack(exprlst, stack, output)
  end

  def convertStack(exprlst, stack, output) do
    cond do
      exprlst == [] && stack == [] -> output;
      exprlst == [] -> output = output ++ [hd stack];
                       stack = stack -- [hd stack];
                       IO.puts "2";
                       convertStack([], stack, output);
      exprlst != [] ->
        token = hd exprlst;
        rest = tl exprlst;
        if Kernel.elem(token,0) == :op do
          cond do
            stack == [] -> stack = [token | stack];
                           IO.puts "3";
                           convertStack(rest, stack, output);
            stack != [] -> compari = compare(token, hd stack);
               case compari do
                 1 -> stack = [token | stack];
                 IO.puts "3";
                      convertStack(exprlst -- [hd exprlst], stack, output);
                 0 -> output = output ++ [hd stack];
                      stack = stack -- [hd stack];
                      stack = [token | stack];
                      IO.puts "4";
                      convertStack(exprlst -- [hd exprlst], stack, output);
                 -1 -> output = output ++ [hd stack];
                       stack = stack -- [hd stack];
                       IO.puts "5";
                       convertStack(exprlst, stack, output);
               end
          end
        else
          output = output ++ [token]
          IO.puts "6";
          IO.inspect(stack)
          IO.inspect(exprlst)
          IO.inspect(output)
          convertStack(exprlst -- [hd exprlst], stack, output);
        end
      end
    end
end
