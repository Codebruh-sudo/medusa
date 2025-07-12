# Use a stable Node.js base image
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy only the package manifest first
COPY package*.json ./

# Install dependencies
RUN npm install --verbose

# Then copy the rest of your app
COPY . .

# Expose the app port
EXPOSE 9000

# Define environment variable (optional)
ENV PORT=9000

# Start your Medusa backend
CMD ["npm", "run", "start"]
