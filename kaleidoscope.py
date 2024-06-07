import plyplus
import sys

class HVisitor(plyplus.STransformer):
  def __init__(self):
    super().__init__()
    self.output = []
  def program(self, expr):
    print(expr)
  def function(self, expr):
    #print(expr.tail)
    return expr.tail
  def expression(self, expr):
    return expr.tail
  def operations(self, expr):
    return expr.tail[0]
  def term(self, expr):
    return expr.tail[0]
  def positivenumber(self, expr):
    return expr.tail[0]
  def bool(self, expr):
    return expr.tail[0]
  def variable(self, expr):
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
