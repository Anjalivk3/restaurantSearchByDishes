// app.js
const express = require('express');
const dotenv = require('dotenv');
dotenv.config();

const app = express();
const searchRouter = require('./routes/search');

app.use(express.json());
app.use('/search', searchRouter);

// health
app.get('/', (req, res) => res.send('Dish search service is up.'));

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
