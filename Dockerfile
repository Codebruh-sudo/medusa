# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy app code
COPY . .

# Set environment variable (optional)
ENV PORT=9000

# Expose port
EXPOSE 9000

# Start Medusa server
CMD ["npm", "run", "start"]
