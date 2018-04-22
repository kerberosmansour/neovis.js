{defaults} = require '../src/defaults.js'
NeoVis     = require('../src/neovis.js').default

describe 'defaults',->
  it 'should work',->
    console.log defaults
    console.log NeoVis