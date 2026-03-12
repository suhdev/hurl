from app import app
from flask import Response


@app.route("/cel")
def cel():
    return Response(
        """{
  "count": 5,
  "name": "Alice",
  "active": true,
  "score": 98.5,
  "items": [1, 2, 3],
  "nested": {
    "value": 42
  },
  "nullable": null
}""",
        mimetype="application/json",
    )


@app.route("/cel-text")
def cel_text():
    return Response("Hello World!", mimetype="text/plain")
