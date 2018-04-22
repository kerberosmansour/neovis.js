neo4j = require '../../vendor/neo4j-javascript-driver/lib/index.js'
require 'fluentnode'

xdescribe 'testing neo4j api', ->

  it 'should work', (done)->
    config =
      encrypted: "ENCRYPTION_OFF",
      trust: "TRUST_ALL_CERTIFICATES"
      #neo4jUri: "bolt://localhost:7687",
      #neo4jUser: "neo4j",
      neo4jPassword: "test",
      server_url: "bolt://localhost:7687",
      server_user: "neo4j",
      server_password: "test",
    this._config = config;
    this._encrypted = config.encrypted || defaults['neo4j']['encrypted'];
    this._trust = config.trust || defaults.neo4j.trust;
    this._driver = neo4j.v1.driver(config.server_url || defaults.neo4j.neo4jUri, neo4j.v1.auth.basic(config.server_user || defaults.neo4j.neo4jUser, config.server_password || defaults.neo4j.neo4jPassword), {encrypted: this._encrypted, trust: this._trust});
    this._query = "match (n) return n limit 25"

    session = this._driver.session();

    actions =
      onNext: (record)=>
        console.log record
        #for key,value of record
        #  console.log key

      onCompleted: =>
        console.log 'all done'
        done()

    session
      .run(this._query, {limit: 30})
      .subscribe actions

