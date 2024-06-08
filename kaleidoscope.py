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

class HVisitor(plyplus.STransformer):
  def __init__(self):
    super().__init__()
    self.output = ''
    self.func = []
    self.argc = []
  def program(self, expr):
    return expr.tail[0]
  
  def classbody(self, expr):
    return expr.tail[0]
# [1, 2, 3, 4]
# thislist = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]
# print(thislist[2:]) "cherry"
# 

  def function(self, expr):
    argcv = []
    self.output += f"void {expr.tail[0]} "
    startfrom = 2
    if type(expr.tail[1]) is list:
      self.output += f"({"".join(expr.tail[1])})"
      argcv.append(expr.tail[1])
    else:
      startfrom = 1
      self.output += "()"
    self.output += '{\n'
    for expresion in expr.tail[startfrom:]:
      self.output += f"\t{expresion};\n"
      
    self.argc = flatten(argcv)
    self.output += '}\n'
    print(self.output) 
    print(self.argc)

  def expressions(self, expr):
    print(expr.tail)
    array = flatten(expr.tail)
    expre = ""
    return (expre.join(array))
  def separatedcallarguments(self, expr):
    array = flatten(expr.tail)
    string = ""
    return(string.join(array))
  def separatedargument(self, expr):
    array = flatten(expr.tail)
    i = 0
    for variable in array:
      if variable != ',':
         array[i] = 'double ' + variable
      i += 1 
       
    return array
  def expression(self, expr):
    return expr.tail
  def functioncall(self, expr):
    calltofunction = f"{expr.tail[0]}({expr.tail[1]})"
    print(calltofunction)
    return calltofunction

  def conditionals(self, expr):
    conditional = f"\tif ({expr.tail[0]}) {'{\n'}"
    print(expr.tail[-1])
    if type(expr.tail[-1]) is list :
      for expresions in expr.tail[1:-1]:
        conditional += f"\t{expresions};\n"
        conditional += "\t} else {\n"
      for expresions in expr.tail[-1]:
        conditional += f"\t{expresions};\n"
      conditional += '\t}\n'
    return conditional
  
  def elseconditional(self, expr):
    return expr.tail
  
  def operations(self, expr):
    return expr.tail[0]
  
  def negativesign(self, expr):
    return expr.tail[0]

  def term(self, expr):
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
  
  def argv(self, expr):
    return expr.tail[0]
  
  def closeparenthesis(self, expr):
    return expr.tail[0]
  def comma(self, expr):
    return expr.tail[0]
  def list(self, expr):
    return ''
  def createobject(self, expr):
    return ''
  def logic(self, expr):
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
        
        cprogram = ''
        cprogram += '#include <iostream> \n\n'
        cprogram += 'using namespace std; \n\n'
        cprogram += v.output
        cprogram += '\nint main () {\n'
        cprogram += '\treturn 0;\n'
        cprogram += '}'
        with open(targetFile, 'w') as target:
          target.write(cprogram)


