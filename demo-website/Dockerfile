FROM nginx:alpine

# Copy website files
COPY index.html /usr/share/nginx/html/
COPY welcome.html /usr/share/nginx/html/

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 