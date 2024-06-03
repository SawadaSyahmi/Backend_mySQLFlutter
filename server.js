const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const db = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '1234',
    database: 'test'
});

db.connect(err => {
    if (err) throw err;
    console.log('MySQL connected...');
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT * FROM users WHERE username = ? AND password = ?';
    db.query(query, [username, password], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            res.send(result[0]);
        } else {
            res.status(401).send({ message: 'Invalid credentials' });
        }
    });
});

app.get('/profile/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM users WHERE id = ?';
    db.query(query, [id], (err, result) => {
        if (err) throw err;
        res.send(result[0]);
    });
});

app.put('/profile/:id', (req, res) => {
    const { id } = req.params;
    const { email, phone } = req.body;
    const query = 'UPDATE users SET email = ?, phone = ? WHERE id = ?';
    db.query(query, [email, phone, id], (err, result) => {
        if (err) throw err;
        res.send({ message: 'Profile updated successfully' });
    });
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
