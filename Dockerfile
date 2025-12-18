# ---------- FRONTEND BUILD ----------
FROM node:18 AS frontend-build

WORKDIR /app/frontend

# Install frontend dependencies
COPY frontend/package*.json ./
RUN npm ci

# Copy frontend source and build
COPY frontend .
RUN npm run build


# ---------- BACKEND ----------
FROM node:18

WORKDIR /app/backend

# Install backend dependencies
COPY backend/package*.json ./
RUN npm ci

# Copy backend source
COPY backend .

# Copy frontend build into backend public folder
COPY --from=frontend-build /app/frontend/build ./public

# Backend port
EXPOSE 5000

# Start backend server
CMD ["node", "server.js"]
