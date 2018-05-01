require 'fluentnode'
NeoVis     = (require '../src/neovis.js').default
Neo4j_Data = require '../src/test-utils/neo4j-data'

describe 'NeoVis | render', ->

  neoVis     = null
  neo4j_Data = null

  config =
    server_url     : 'bolt://localhost:7687',
    server_user    : 'neo4j',
    server_password: 'test' #servant-jackets-fives',
    initial_cypher : 'match (n)-[r]-(p) return n,r,p limit 3',
    container_id   : 'viz'

  beforeEach ->
    neoVis     = new NeoVis(config)
    neo4j_Data = new Neo4j_Data()

  xit 'exec_Neo4j_query', ->
    query =' match (n)-[r]-(p) return n,r,p limit 1'                          # set test query
    neoVis.exec_Neo4j_query(query)                                             # call async method (which returns a Promise)
      .then (results)->                                                       # get results
        results.records[0]._fields[0].constructor.name.assert_Is 'Node'       # check if first field of first record is a Node
        results.summary.statement.text                .assert_Is query        # confirm query executed is the one set above
        results.summary.counters._stats.nodesCreated  .assert_Is 0            # confirm that no new nodes where created

        record = results.records[0]                                           # get the first (and only) record
        neo4j_Data.rawData_on_Next_Record()            .assert_Is record      # confirm that it matches the Neo4j_Data dataset
        neo4j_Data.rawData_on_Next_Record_Using_Types().assert_Is record      # both the raw json one and the one with the correct types


  xit 'transform_Neo4j_Records_To_VisJs (live data)', ->
    query =' match (n)-[r]-(p) return n,r,p limit 3'
    neoVis.exec_Neo4j_query(query)                                            # call async method (which returns a Promise)
      .then (results)->
        neoVis.transform_Neo4j_Records_To_VisJs(results.records)              # transform records in visJs nodes

        neoVis._nodes._keys().assert_Is [ '0', '6', '7', '8' ]

        neoVis._nodes['0'].assert_Is { id: 0, value: 1, label: 'Movie' , group: 'Movie' , title: '' }
        neoVis._nodes['6'].assert_Is { id: 6, value: 1, label: 'Person', group: 'Person', title: '' }
        neoVis._nodes['7'].assert_Is { id: 7, value: 1, label: 'Person', group: 'Person', title: '' }
        neoVis._nodes['8'].assert_Is { id: 8, value: 1, label: 'Person', group: 'Person', title: '' }

        neoVis._edges._keys().assert_Is [ '5', '6', '7' ]

        neoVis._edges['5'].assert_Is { id: 5, from: 6, to: 0, title: ''                                , value: 1, label: 'DIRECTED' }
        neoVis._edges['6'].assert_Is { id: 6, from: 7, to: 0, title: ''                                , value: 1, label: 'PRODUCED' }
        neoVis._edges['7'].assert_Is { id: 7, from: 8, to: 0, title: '<strong>roles:</strong> Emil<br>', value: 1, label: 'ACTED_IN' }

  it 'transform_Neo4j_Records_To_VisJs (mock data)', ->
    neoVis._records = [ [ neo4j_Data.rawData_on_Next_Record_Using_Types()._fields ]]

    neoVis.transform_Neo4j_Records_To_VisJs()               # transform records in visJs nodes

    neoVis._nodes._keys().assert_Is [ '0', '8' ]

    neoVis._nodes['0'].assert_Is { id: 0, value: 1, label: 'Movie' , group: 'Movie' , title: '' }
    neoVis._nodes['8'].assert_Is { id: 8, value: 1, label: 'Person', group: 'Person', title: '' }

    neoVis._edges._keys().assert_Is [ '7' ]

    neoVis._edges['7'].assert_Is { id: 7, from: 8, to: 0, title: '<strong>roles:</strong> Emil<br>', value: 1, label: 'ACTED_IN' }

