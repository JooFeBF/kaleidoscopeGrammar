import plyplus
# import numpy
import sys
import builtins
from collections.abc import Iterable

def flatten(x):
    result = []
    for el in x:
        if hasattr(el, "__iter__") and not isinstance(el, str):
            result.extend(flatten(el))
        else:
            result.append(el)
    return result

cprogram = ''

class HVisitor(plyplus.STransformer):
  def __init__(self):
    super().__init__()
    self.output = []
  def program(self, expr):
    return expr.tail[0]
  
  def classbody(self, expr):
    return expr.tail[0]

  def expressions(self, expr):
    array = flatten(expr.tail)
    expre = ""
    print(array)
    return array
  def separatedcallarguments(self, expr):
    array = flatten(expr.tail)
    string = ""
    print(string.join(array))
    return string
  def expression(self, expr):
    return expr.tail

  def operations(self, expr):
    return expr.tail[0]
  
  def negativesign(self, expr):
    return expr.tail[0]

  def term(self, expr):
    return expr.tail[0]
  
  def conditionals(self, expr):
    return expr.tail[0]
  
  def arguments(self, expr):
    return expr.tail
  
  def funcname(self, expr):
    return expr.tail[0]
  
  def variable(self, expr):
    return expr.tail[0]
  
  def callarguments(self, expr):
    return expr.tail
  
  def positivenumber(self, expr):
    return expr.tail[0]
  
  def bool(self, expr):
    return expr.tail[0]
  
  def openparenthesis(self, expr):
    return expr.tail[0]
  
  def closeparenthesis(self, expr):
    return expr.tail[0]
  
  def comma(self, expr):
    return expr.tail[0]
if __name__ == '__main__':
  if len(sys.argv) != 3:
    print("Example call: {} input.kl output.cpp".format(sys.argv[0]))
  else:
    sourceFile = sys.argv[1]
    targetFile = sys.argv[2]
    with open('kaleidoscope.g', 'r') as grm:
      with open(sourceFile, 'r') as scode:
        parser = plyplus.Grammar(grm)
        source = scode.read();
        t = parser.parse(source)
        t.to_png_with_pydot(r"tree.png")
        v = HVisitor()
        v.transform(t)
        with open(targetFile, 'w') as target:
          target.write(cprogram)


