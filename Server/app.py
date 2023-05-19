from flask import Flask, render_template, jsonify, request, make_response
from rdflib import Graph

import Constants

app = Flask(__name__)

graph = Graph()
graph.parse("./Ontology/ontology.xml",format="xml")

@app.route("/")
def index():
  return render_template('index.html', message = "hello world")

@app.route("/query",methods=['GET'])
def query():
  queryString = request.args.get("q")
  if queryString == None:
    return make_response(jsonify({"error":"Invalid query parameter", "status": Constants.BAD}), Constants.BAD)

  try :

    response = graph.query(queryString)

    data = []
    for row in response:
      if isinstance(row, bool):
        return make_response(jsonify({"response": row, "status": Constants.OK}), Constants.OK)
      
      elementArray = [] 
      for element in row:
        elementArray.append(element)
      data.append(elementArray)

    return make_response(jsonify({"response": data, "status": Constants.OK}), Constants.OK) 

  except Exception as e:
    print(e)
    return make_response(jsonify({"error": "Invalid Query", "status": Constants.BAD}), Constants.BAD) 
  

if __name__ == "__main__":
  
  app.run(debug=True)
  