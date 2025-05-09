# Use official Node.js 16 image
FROM node:16-slim

# Set working directory
WORKDIR /app

# Copy dependency files first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the app (including public and src folders)
COPY . .

# Build React app
RUN npm run build

# Expose port (React apps typically run on 3000 during dev, but for prod you might serve the build with Nginx or Express)
EXPOSE 3000

# Start the app using a static server like serve
RUN npm install -g serve

# Serve the build folder
CMD ["serve", "-s", "build", "-l", "3000"]
