# Use an official Node.js runtime as a parent image
FROM node:20 AS build


# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application's source code to the container
COPY . .

# Build the React application
RUN npm run build


# Use an official Nginx image to serve the build
FROM nginx:alpine

# Copy the build output to the Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html
#COPY --from=build /app .

# Expose the port Nginx runs on
EXPOSE 8383

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
