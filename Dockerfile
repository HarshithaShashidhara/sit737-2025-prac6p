
FROM node:18-slim

  # Create app directory
WORKDIR /app
  
  # Install dependencies first for better cache efficiency
COPY package*.json ./
RUN npm ci --only=production
  
  # Copy source files
COPY . .
  
  # Set environment variables
ENV NODE_ENV=production
  
  # Use non-root user for better security (create one first)
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
  USER appuser
  
  # Expose port
  EXPOSE 3000
  
  # Health check to monitor container status
  HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1
  
  # Start the app
  CMD ["node", "index.js"]
  