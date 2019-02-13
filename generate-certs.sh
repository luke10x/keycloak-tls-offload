
apt-get update \
    && apt-get install -y openssl \
    && rm -rf /var/lib/apt/lists/*

mkdir /ca
mkdir /certs

openssl dhparam -out /certs/dhparam-2048.pem 2048

# Generate CA private key: ca.key
openssl genrsa -out /ca/ca.key 2048

# Generate a root certificate: root.pem
openssl req -x509 -new -nodes \
    -key /ca/ca.key \
    -sha256 -days 1825 \
    -subj "/C=DE/ST=NRW/L=Berlin/O=o/OU=pps/CN=www/emailAddress=email" \
    -out /ca/root.pem

# Create a private key
openssl genrsa -out /certs/google.com.key 2048

# Create a CSR
openssl req -new -key /certs/google.com.key \
    -subj "/C=DE/ST=NRW/L=Berlin/O=o/OU=pps/CN=google.com/emailAddress=email" \
    -out /certs/google.com.csr

cat >/certs/google.com.ext <<EOL
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = google.com
DNS.2 = www.google.com
EOL

openssl x509 -req -in /certs/google.com.csr \
    -CA /ca/root.pem \
    -CAkey /ca/ca.key -CAcreateserial \
    -out /certs/google.com.crt -days 1825 -sha256 \
    -extfile /certs/google.com.ext

ls /ca -las
ls /certs -las
