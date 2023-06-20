import WebSocket from 'ws';

class WebSocketHandler {
    private url: string;
    private socket: any;

  constructor(url: string) {
    this.url = url;
    this.socket = null;
  }

  connect() {
    this.socket = new WebSocket(this.url);

    this.socket.onopen = () => {
      console.log('WebSocket connection established.');

      // You can send initial messages or perform other actions here
      this.socket.send('Hello WebSocket server!');
    };

    this.socket.onmessage = (event: {data: {message: string}}) => {
      const message = event.data;
      console.log('Received message:', message);

      // Handle the received message as needed
    };

    this.socket.onclose = () => {
      console.log('WebSocket connection closed.');
    };

    this.socket.onerror = (error: string) => {
      console.error('WebSocket error:', error);
    };
  }

  send(message: any) {
    if (this.socket && this.socket.readyState === WebSocket.OPEN) {
      this.socket.send(message);
    } else {
      console.error('WebSocket connection not open.');
    }
  }

  close() {
    if (this.socket) {
      this.socket.close();
    }
  }
}

export default WebSocketHandler;
