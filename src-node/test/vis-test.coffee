vis   = require '../../vendor/vis/dist/vis-network.min.js'
vis   = require '../../vendor/vis/dist/vis.js'

#{JSDOM} = require 'jsdom'

xdescribe 'visjs test', ->
  it 'should work',->
    edges = new vis.DataSet()

#    window =  new JSDOM('<div id="viz"/>').window
#    document = window.document
#    container =  window.document.getElementById('viz')

    nodes = new vis.DataSet([
      {id: 1, label: 'Node 1'},
      {id: 2, label: 'Node 2'},
      {id: 3, label: 'Node 3'},
      {id: 4, label: 'Node 4'},
      {id: 5, label: 'Node 5'}
    ])


    edges = new vis.DataSet([
      {from: 1, to: 3},
      {from: 1, to: 2},
      {from: 2, to: 4},
      {from: 2, to: 5}
    ]);

    data =
      nodes: nodes,
      edges: edges

    options = {};

    #console.log document.getElementById('vi= windowz')
#    global.window    = window
#    global.document  = document
#    global.navigator = window.navigator
#    global.Element   = window.Element
    jsdom_global = require('jsdom-global')
    jsdom_global =  jsdom_global(
      "<div id='mygraph'></div>",
      { skipWindowCheck: true}
    );

    container = document.getElementById('mygraph');
    #console.log container

    #canvas = require('canvas-prebuilt');
    #console.log new canvas().getContext()
    #console.log context
    network = new vis.Network(container, data, options);
    #console.log container.innerHTML

    canvas =  document.getElementsByTagName("canvas")[0]

    context = canvas.getContext('2d')

    console.log canvas.pngStream


#    context.beginPath();
#    context.arc(100, 75, 50, 0, 2 * Math.PI);
#    context.stroke();

#    GIFEncoder = require('gifencoder');
#    encoder = new GIFEncoder(854, 480);

    #console.log encoder.addFrame(context)
    #console.log  'here'
    #console.log network
