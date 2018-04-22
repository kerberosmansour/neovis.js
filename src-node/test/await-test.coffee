
describe 'await-test', ->
  sleep = (ms) ->
    new Promise (resolve) ->
      setTimeout resolve, ms
  it 'should work',->
    console.log  'before await'
    await sleep 1000
    console.log 'after await'