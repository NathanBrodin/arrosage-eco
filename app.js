const express = require('express');
const http = require('http');
const socketIO = require('socket.io');

const app = express();
app.use(express.json());
const server = http.createServer(app);
const io = socketIO(server);

app.get('/data', (req, res) => {
    const sampleData =
    {
        battery: 85,
        moisture: 12,
        sun: 75,
        temperature: 12,
        water: 20,
        currentPlantId: 4
    };
    res.json(sampleData);
});

io.on('connection', (socket) => {
    console.log('User connected');

    socket.on('disconnect', () => {
        console.log('User disconnected');
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

app.post('/send-data', (req, res) => {
  const data = req.body;
  console.log('Received data:', data);// Implement this function to process the received data
  res.sendStatus(200);
});

