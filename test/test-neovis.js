// TODO: write tests

value = require('../src/test')

jsdom_global = require('jsdom-global')
jsdom_global =  jsdom_global("", { });

defaults = require('../src/defaults')
neovis = require('../src/neovis')


describe ("test", ()=>
{
    it ("should work", ()=>
    {
        console.log(defaults.defaults)
        console.log(new neovis.default({}))
    })
})