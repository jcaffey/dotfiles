# Use the lightweight Alpine-based Nginx image
FROM nginx:alpine

# Optional: Remove default Nginx page (uncomment if needed)
# RUN rm -rf /usr/share/nginx/html/*

# Use custom nginx config
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy your static files (HTML, CSS, JS, images, etc.) into the Nginx html directory
# Assumes your files are in the same directory as the Dockerfile (or a subfolder like ./build or ./public)
COPY ./build/site /usr/share/nginx/html/

# Expose port 80 (standard HTTP)
EXPOSE 80
