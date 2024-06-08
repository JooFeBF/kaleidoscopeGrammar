import plyplus
import sys

cprogram = ''

class HVisitor(plyplus.STransformer):
  def __init__(self):
    super().__init__()
    self.output = []


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
        lista = t.select('function > expression *')
        print(lista)
        t.to_png_with_pydot(r"tree.png")
        v = HVisitor()
        v.transform(t)
        with open(targetFile, 'w') as target:
          target.write(cprogram)


