neo4j        = require '../../vendor/neo4j-javascript-driver/lib/index.js'

Integer      = require '../../vendor/neo4j-javascript-driver/lib/v1/integer.js'
Node         = neo4j.v1.types.Node
Relationship = neo4j.v1.types.Relationship

class Neo4j_Data

  # here is the record received from the query: 'match (n)-[r]-(p) return n,r,p limit 1'
  rawData_on_Next_Record: ->
    return  {
      keys    : [ "n", "r", "p" ],
      length  : 3,
      _fields : [
        {
          identity  : "low": 8, "high": 0
          labels    : [ "Person" ],
          properties: "name": "Emil Eifrem", "born": { "low": 1978, "high": 0 }
        },
        {
          identity  : "low": 7,"high": 0
          start     : "low": 8,"high": 0
          end       : "low": 0,"high": 0
          type      : "ACTED_IN"
          properties: "roles": [ "Emil" ]
        },
        {
          identity  : "low": 0, "high": 0
          labels    : [ "Movie" ]
          properties : "title": "The Matrix", "tagline": "Welcome to the Real World", "released": {  "low": 1999,  "high": 0 }
        }
      ],
      "_fieldLookup": "n": 0,"r": 1,"p": 2
    }

  # here is the same record as above (but created using neo4j Javascript API
  rawData_on_Next_Record_Using_Types: ()->

    Number::to_Integer = ()->                       # add to_Integer method to Javascript Number type
      return Integer.default.fromNumber @

    identity_A =  Integer.default.fromNumber(8)     # not very readable

    identity_B =  8.to_Integer()                    # much better :)

    identity_A.assert_Is identity_B

    node_1       = new Node(         8.to_Integer() , [ "Person" ]   , {"name": "Emil Eifrem", "born": 1978.to_Integer() })
    node_2       = new Node(         0.to_Integer() , [ "Movie" ]    , {"title": "The Matrix", "tagline": "Welcome to the Real World", "released": 1999.to_Integer() } )
    relationship = new Relationship( 7.to_Integer() , 8.to_Integer() , 0.to_Integer()    , "ACTED_IN" , {"roles": [ "Emil" ]})

    data =
      keys        : [ "n", "r", "p" ],
      length      : 3
      _fields     : [node_1, relationship, node_2]
      _fieldLookup: "n": 0,"r": 1,"p": 2
    return data


module.exports =  Neo4j_Data

