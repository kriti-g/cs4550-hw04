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
    |> solve
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
          token = hd postfix;
          if Kernel.elem(token,0) == :num do
            token = Kernel.elem(token, 1);
            stack = [token | stack];
            postfix = tl postfix;
            solveStack(postfix, stack);
          else
            num1 = hd stack;
            stack = tl stack;
            num2 = hd stack;
            stack = tl stack;
            op = hd postfix;
            postfix = tl postfix;
            result = evaluate(num1, num2, op);
            stack = [result | stack];
            solveStack(postfix, stack);
          end
    end
  end

  def evaluate(num1, num2, op) do
    op = Kernel.elem(op, 1);
    case op do
      "*" -> num2 * num1;
      "/" -> num2 / num1;
      "+" -> num2 + num1;
      "-" -> num2 - num1;
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
                       convertStack([], stack, output);
      exprlst != [] ->
        token = hd exprlst;
        rest = tl exprlst;
        if Kernel.elem(token,0) == :op do
          cond do
            stack == [] -> stack = [token | stack];
               convertStack(rest, stack, output);
            stack != [] -> compari = compare(token, hd stack);
               case compari do
                 1 -> stack = [token | stack];
                      convertStack(rest, stack, output);
                 0 -> output = output ++ [hd stack];
                      stack = tl stack;
                      stack = [token | stack];
                      convertStack(rest, stack, output);
                 -1 -> output = output ++ [hd stack];
                      stack = tl stack;
                      convertStack(exprlst, stack, output);
               end
          end
        else
          output = output ++ [token]
          convertStack(rest, stack, output);
        end
      end
    end
end
