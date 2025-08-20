FROM jupyter/scipy-notebook:latest

# Switch to root to install system packages
USER root

# Install PostgreSQL client library for psycopg
RUN apt-get update && \
    apt-get install -y libpq-dev postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to jovyan user
USER jovyan

# Copy requirements file
COPY requirements.txt /tmp/requirements.txt

# Install Python packages
RUN pip install --quiet --no-cache-dir -r /tmp/requirements.txt

# Set working directory
WORKDIR /home/jovyan/work

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Lab without token for development
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.allow_root=True"]
