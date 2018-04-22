module.exports = function (wallaby) {
    return {
        files: [
            //'src-node/src/**/*.coffee',
            { pattern: 'vendor/neo4j-javascript-driver/**/*.js', instrument: false, load: true , ignore: false },
            { pattern: 'vendor/vis/dist/*.js'                  , instrument: false, load: true , ignore: false },
            //{ pattern: 'vendor/vis/dist/vis-network.min.css'   , instrument: false, load: false, ignore: false },
            //{pattern: 'node_modules/babel-polyfill/dist/polyfill.js', instrument: false},
            'src/**/*.js'
        ],

        tests: [
            'src-node/test/**/*.coffee'
        ],
        compilers: {
        },
        env: {

            type: 'node',
            runner :'node',
            params: {
                runner: `-r ${require.resolve('esm')}`
            }
        }
    }
}