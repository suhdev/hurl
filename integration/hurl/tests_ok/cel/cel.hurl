# Test CEL expressions in assertions and captures

# CEL assertions with a JSON response body
# The response body is automatically exposed as 'body' in the CEL context
GET http://localhost:8000/cel
HTTP 200
[Asserts]
cel "body.count == 5" == true
cel "body.name == 'Alice'" == true
cel "body.active" == true
cel "body.count > 3" == true
cel "body.score > 90.0" == true
cel "size(body.items) == 3" == true
cel "body.nested.value == 42" == true
cel "body.nullable == null" == true
cel "body.count + 1 == 6" == true
cel "body.count * 2 == 10" == true


# CEL captures from a JSON response body
GET http://localhost:8000/cel
HTTP 200
[Captures]
cel_count: cel "body.count"
cel_name: cel "body.name"
cel_active: cel "body.active"
cel_computed: cel "body.count + 1"
cel_list_size: cel "size(body.items)"
[Asserts]
variable "cel_count" == 5
variable "cel_name" == "Alice"
variable "cel_active" == true
variable "cel_computed" == 6
variable "cel_list_size" == 3


# CEL expressions can reference Hurl variables
GET http://localhost:8000/cel
[Options]
variable: threshold=3
HTTP 200
[Asserts]
cel "body.count > threshold" == true


# CEL with a plain text (non-JSON) response: body is exposed as a string
GET http://localhost:8000/cel-text
HTTP 200
[Asserts]
cel "body == 'Hello World!'" == true


# CEL expressions can reference built-in Hurl response variables:
# status, duration, url, ip, and version are automatically available
GET http://localhost:8000/cel
HTTP 200
[Asserts]
cel "status == 200" == true
cel "duration >= 0" == true
cel "url == 'http://localhost:8000/cel'" == true
cel "version == '1.1'" == true
