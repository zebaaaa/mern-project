# ---------- FRONTEND BUILD ----------
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# ---------- BACKEND ----------
FROM node:18
WORKDIR /app

COPY backend/package*.json ./backend/
RUN cd backend && npm install

COPY backend ./backend

# Copy frontend build
COPY --from=frontend-build /app/frontend/build ./backend/public

EXPOSE 5000
CMD ["node", "backend/server.js"]
