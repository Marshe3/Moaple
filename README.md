# Moaple

## Purpose
Moaple is a cutting-edge application designed to simplify your daily tasks and enhance productivity. It aims to provide users with an intuitive interface and powerful functionalities to manage tasks efficiently.

## Tech Stack
- **Frontend:** React.js, CSS, and HTML
- **Backend:** Node.js with Express
- **Database:** MongoDB
- **Authentication:** JWT (JSON Web Tokens)

## Dependencies
- **Express**: Web framework for Node.js
- **Mongoose**: MongoDB object modeling for Node.js
- **dotenv**: Module to load environment variables
- **jsonwebtoken**: Implementation of JSON Web Tokens

## Setup Instructions
To set up the Moaple project locally, follow these instructions:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Marshe3/Moaple.git
   cd Moaple
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Set up environment variables**:  
   Create a `.env` file in the root directory and add your configuration settings. An example `.env` file would look like:
   ```env
   PORT=5000
   MONGO_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret
   ```

4. **Run the application**:
   ```bash
   npm start
   ```

Your application should now be running on `http://localhost:5000`.

## Contribution
Feel free to submit pull requests or suggestions to improve the Moaple project. Your contributions are highly appreciated!