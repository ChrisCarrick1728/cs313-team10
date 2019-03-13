var express = require('express')
require('dotenv').config()
const connectionString = process.env.DATABASE_URL
const { Pool, Client } = require('pg')
const pool = new Pool({connectionString: connectionString})

express()
    .get('/', (req, res) => {
        console.log(connectionString)
        test(res)
    })
    .listen(8000, () => console.log('Listening on port: 8000'))

function callback(data, res) {
    for (var i = 0; i < data.length; i++) {
        console.log(data[i])
    }
}

function test(res) {
    var sql = "SELECT * FROM test";

    pool.query(sql, function(err, result) {
        // If an error occurred...
        if (err) {
            console.log("Error in query: ")
            console.log(err);
        }

        // Log this to the console for debugging purposes.
        console.log("Back from DB with result:");
        console.log(result.rows);
        for (var i = 0; i < result.rows.length; i++) {
            res.write(result.rows[i].name + '</br>')
        }
        res.end()

    }); 
}