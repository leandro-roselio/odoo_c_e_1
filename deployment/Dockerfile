FROM python:3.12-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    node-less \
    node-clean-css \
    python3-dev \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf
RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb \
    && apt-get install -y ./wkhtmltox.deb \
    && rm wkhtmltox.deb

# Set working directory
WORKDIR /opt/odoo

# Copy requirements and install
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy Odoo source
COPY . .

# Copy start script
COPY ./deployment/start.sh /opt/odoo/start.sh
RUN chmod +x /opt/odoo/start.sh

# Expose Odoo ports (Render will use $PORT)
EXPOSE 8069

# Set entrypoint
CMD ["/opt/odoo/start.sh"]
