FROM python:3.9-slim
# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

# BUILD AND RUN WITH FOLLOWING COMMAND
# docker build -t accounts .
# docker run --rm \
#     --link postgresql \
#     -p 8080:8080 \
#     -e DATABASE_URI=postgresql://postgres:postgres@postgresql:5432/postgres \
#     accounts
