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
    #|> solve
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

  def solve(postfix) do
    stack = []
    solution = solveStack(postfix, stack)
  end

  def solveStack(postfix, stack) do
    cond do
      postfix == [] -> hd stack;
      postfix != [] ->
      IO.inspect(0)
      IO.inspect(postfix)
      IO.inspect(stack)
          token = hd postfix;
          if Kernel.elem(token,0) == :num do
            stack = [token | stack];
            postfix = tl postfix;
            solveStack(postfix, stack);
            IO.inspect(1)
            IO.inspect(postfix)
            IO.inspect(stack)
          else
            num1 = hd stack;
            stack = tl stack;
            num2 = hd stack;
            stack = tl stack;
            op = hd postfix;
            postfix = tl postfix;
            result = evaluate(num1, num2, op);
            stack = [result | stack];
            IO.inspect(2)
            IO.inspect(postfix)
            IO.inspect(stack)
            solveStack(postfix, stack);
          end
    end
  end

  def evaluate(num1, num2, op) do
    op = Kernel.elem(op, 1);
    num1 = Kernel.elem(num1, 1);
    num2 = Kernel.elem(num2, 1);
    case op do
      "*" -> num1 * num2;
      "/" -> num1 / num2;
      "+" -> num1 + num2;
      "-" -> num1 - num2;
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
                       IO.inspect(1)
                       IO.inspect(exprlst)
                       IO.inspect(stack)
                       IO.inspect(output)
                       convertStack([], stack, output);
      exprlst != [] ->
        token = hd exprlst;
        rest = tl exprlst;
        if Kernel.elem(token,0) == :op do
          cond do
            stack == [] -> stack = [token | stack];
            IO.inspect(2)
            IO.inspect(exprlst)
            IO.inspect(stack)
            IO.inspect(output)
               convertStack(rest, stack, output);
            stack != [] -> compari = compare(token, hd stack);
               case compari do
                 1 -> stack = [token | stack];
                      convertStack(rest, stack, output);
                      IO.inspect(3)
                      IO.inspect(exprlst)
                      IO.inspect(stack)
                      IO.inspect(output)
                 0 -> output = output ++ [hd stack];
                      stack = tl stack;
                      stack = [token | stack];
                      IO.inspect(4)
                      IO.inspect(exprlst)
                      IO.inspect(stack)
                      IO.inspect(output)
                      convertStack(rest, stack, output);
                 -1 -> output = output ++ [hd stack];
                      stack = tl stack;
                      IO.inspect(5)
                      IO.inspect(exprlst)
                      IO.inspect(stack)
                      IO.inspect(output)
                      convertStack(exprlst, stack, output);
               end
          end
        else
          output = output ++ [token]
          IO.inspect(6)
          IO.inspect(exprlst)
          IO.inspect(stack)
          IO.inspect(output)
          convertStack(rest, stack, output);
        end
      end
    end
end
