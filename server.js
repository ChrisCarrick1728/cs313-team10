var express = require('express')
require('dotenv').config()
const connectionString = process.env.DATABASE_URL
var path = require('path')
const { Pool, Client } = require('pg')
const pool = new Pool({connectionString: connectionString})

express()
    .use(express.static(path.join(__dirname, 'public')))
    .set('views', path.join(__dirname, 'views'))
    .set('view engine', 'ejs')
    .get('/', (req, res) => {
        res.render('pages/index')
    })
    .get('/services/getPerson', (req, res) => {
        getPerson(req.query.id, res)
        // return json object person
    })
    .listen(8000, () => console.log('Listening on port: 8000'))

function callback(data, res) {
    for (var i = 0; i < data.length; i++) {
        console.log(data[i])
    }
}

function getPerson(id, res) {
    var sql = "SELECT * FROM person_table WHERE person_id=" + id;
    pool.query(sql, function(err, result) {
        if (err) {
            console.log("Error in Query" + err)
        }
        res.writeHead(200, {"Content-type": "application/json"})
        res.write(JSON.stringify(result.rows))
        res.end()
    })
}